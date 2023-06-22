import 'dart:convert';
import 'dart:math';

import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logger/logger.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/sse/sse.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchCategoriesUsecase fetchCategories;
  final FetchCategoriesBySectionUsecase fetchCategoriesBySection;
  final ChangeConversationUsecase changeConversation;
  final SendMessagesUsecase sendMessage;
  final GetResponseMessagesUsecase getResponseMessages;
  final GetConversationByIdUsecase getConversationById;
  // late StreamSubscription<String?> streamSubscription;
  ChatBloc({
    required this.fetchCategoriesBySection,
    required this.fetchCategories,
    required this.changeConversation,
    required this.sendMessage,
    required this.getResponseMessages,
    required this.getConversationById,
  }) : super(
          ChatState(
            textEditingController: TextEditingController(),
            focusNode: FocusNode(),
          ),
        ) {
    on<ChatMessageSent>(_onChatMessageSent);
    on<ChatCategoriesFetched>(_onChatCategoriesFetched);
    on<ChatCategoriesBySectionFetched>(_onChatCategoriesBySectionFetched);
    on<ChatConversationChanged>(_onChatConversationChanged);
    on<ChatConversationCleared>(_onChatConversationCleared);
    on<ChatMessageAdded>(_onChatMessageAdded);
    on<ChatTypingStatusChanged>(_onChatTypingStatusChanged);
    on<ChatMessageJoined>(_onChatMessageJoined);
    on<ChatMessageAnswerGot>(_onChatMessageAnswerGot);
    on<ChatMessageModChanged>(_onChatMessageModChanged);
    on<ChatIncomingMessageLoaded>(_onChatIncomingMessageLoaded);
    on<ChatFocusNodeDisposed>(_onChatFocusNodeDisposed);
    on<ChatConversationInited>(_onChatConversationInited);
    on<ChatConversationFromNotificationInited>(
        _onChatConversationFromNotificationInited);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onChatConversationFromNotificationInited(
    ChatConversationFromNotificationInited event,
    Emitter<ChatState> emit,
  ) async {
    state.textEditingController?.clear();
    emit(
      state.copyWith(
        conversationStatus: Status.loading,
        conversation: const Conversation(),
        messages: [],
        clearNewMessage: true,
      ),
    );
    final res = await getConversationById(event.conversationId);

    return res.fold(
      (l) => Logger().w(l),
      (conversation) {
        state.focusNode?.requestFocus();
        emit(
          state.copyWith(
            conversation: conversation,
            // theme: theme(conversation.category?.colorTheme),
            conversationStatus: Status.loaded,
          ),
        );
        final messages = conversation.messages;
        if (messages != null) {
          for (final message in messages) {
            final author =
                message.role == Role.user ? state.sender : state.receiver;
            final text = types.TextMessage(
              author: author!,
              createdAt: message.createdAt?.millisecondsSinceEpoch,
              id: _randomString(),
              text: message.content ?? '',
            );
            add(ChatMessageAdded(textMessage: text));
          }
        }
      },
    );
  }

  void _onChatConversationInited(
    ChatConversationInited event,
    Emitter<ChatState> emit,
  ) async {
    final historical = event.historical;
    state.textEditingController?.clear();
    emit(
      state.copyWith(
        conversationStatus: Status.loading,
        conversation: const Conversation(),
        messages: [],
        clearNewMessage: true,
      ),
    );
    state.focusNode?.requestFocus();
    Category? categorySelected;
    for (final CategoriesBySection catSection in state.categoriesBySection) {
      if (catSection.categories != null) {
        for (final Category category in catSection.categories!) {
          if (category.id == historical.category) {
            categorySelected = category;
            break;
          }
        }
      }
    }
    final conversation =
        Conversation(id: historical.idString, category: categorySelected);
    emit(
      state.copyWith(
        conversation: conversation,
        // theme: theme(conversation.category?.colorTheme),
        conversationStatus: Status.loaded,
      ),
    );
    for (final message in historical.messages) {
      final author = message.role == Role.user ? state.sender : state.receiver;
      final text = types.TextMessage(
        author: author!,
        createdAt: message.createdAt?.millisecondsSinceEpoch,
        id: _randomString(),
        text: message.content ?? '',
      );
      add(ChatMessageAdded(textMessage: text));
    }
  }

  void _onChatCategoriesBySectionFetched(
    ChatCategoriesBySectionFetched event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(catStatus: Status.loading));
    final res = await fetchCategoriesBySection(NoParams());

    return res.fold(
      (l) {
        emit(
          state.copyWith(
            catStatus: Status.failed,
            failure: l,
          ),
        );
      },
      (categoriesBySection) => emit(
        state.copyWith(
          categoriesBySection: categoriesBySection,
          catStatus: Status.loaded,
        ),
      ),
    );
  }

  void _onChatFocusNodeDisposed(
    ChatFocusNodeDisposed event,
    Emitter<ChatState> emit,
  ) {
    state.focusNode?.dispose();
  }

  void _onChatIncomingMessageLoaded(
    ChatIncomingMessageLoaded event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(incoming: event.message));
  }

  void _onChatMessageModChanged(
    ChatMessageModChanged event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(streamMessage: event.value));
  }

  void _onChatMessageAnswerGot(
    ChatMessageAnswerGot event,
    Emitter<ChatState> emit,
  ) async {
    final res = await getResponseMessages(event.conversationId);
    res.fold(
        (l) => emit(
              state.copyWith(
                messageStatus: Status.failed,
                failure: ServerFailure(
                  info: e.toString(),
                ),
              ),
            ), (rs) async {
      String messageJoined = '';
      try {
        // streamSubscription =
        rs.data?.stream
            .transform(unit8Transformer)
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .transform(const SseTransformer())
            .listen((event) async {
          debugPrint(event.data);

          String trunck = '';

          if (event.data == ' ') {
            trunck = '\n\n';
          }
          if (event.data.length > 1) {
            trunck = event.data.substring(1);
          }
          add(
            const ChatTypingStatusChanged(
              isTyping: true,
            ),
          );
          if (trunck == endMessageMarker) {
            debugPrint(messageJoined);
            // streamSubscription.cancel();
            state.focusNode?.requestFocus();
            add(ChatMessageJoined(newMessage: messageJoined.trim()));
          }
          if (trunck != endMessageMarker) {
            state.textEditingController?.text =
                '${state.textEditingController?.text}$trunck';

            messageJoined = '$messageJoined$trunck';
            add(ChatIncomingMessageLoaded(message: messageJoined));
          }
        });
      } catch (e) {
        emit(state.copyWith(
            messageStatus: Status.failed,
            failure: ServerFailure(info: e.toString())));
      }
    });
  }

  void _onChatTypingStatusChanged(
    ChatTypingStatusChanged event,
    Emitter<ChatState> emit,
  ) {
    emit(
      state.copyWith(
        isTyping: event.isTyping,
        messageStatus: event.isTyping ? Status.loaded : Status.init,
      ),
    );
  }

  void _onChatMessageAdded(
    ChatMessageAdded event,
    Emitter<ChatState> emit,
  ) {
    final textAnswer = event.textMessage;
    emit(
      state.copyWith(
        messages: List.of(state.messages!)..insert(0, textAnswer),
        messageStatus: Status.init,
      ),
    );
  }

  void _onChatMessageJoined(
    ChatMessageJoined event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(newMessage: event.newMessage, isTyping: false));
  }

  void _onChatConversationCleared(
    ChatConversationCleared event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(clearConversation: true));
  }

  void _onChatConversationChanged(
    ChatConversationChanged event,
    Emitter<ChatState> emit,
  ) async {
    state.textEditingController?.clear();
    emit(
      state.copyWith(
        conversationStatus: Status.loading,
        conversation: const Conversation(),
      ),
    );
    final res =
        await changeConversation(PChangeConversation(category: event.category));

    res.fold(
      (l) {
        emit(
          state.copyWith(
            conversationStatus: Status.failed,
            failure: l,
            clearConversation: true,
          ),
        );
      },
      (conversation) {
        state.focusNode?.requestFocus();
        emit(
          state.copyWith(
            conversation: conversation,
            // theme: theme(event.category.colorTheme),
            conversationStatus: Status.loaded,
            //TODO check this
            messages: [],
          ),
        );
      },
    );
  }

  void _onChatMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    if (state.streamMessage! &&
        state.messages!.isNotEmpty &&
        state.newMessage != null) {
      /*
        the last message on the screen is still the customMessage build from the textEditingController,
        then you have to add the actual message here before inserting the new message from the user typing
      */

      //first clear the text controller

      state.textEditingController?.clear();
      final textAnswer = types.TextMessage(
        author: state.receiver!,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _randomString(),
        text: state.newMessage ?? '',
      );

      emit(
        state.copyWith(
          messages: List.of(state.messages!)..insert(0, textAnswer),
          messageStatus: Status.init,
        ),
      );
    }
    final textMessage = types.TextMessage(
      author: state.sender!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _randomString(),
      text: event.textMessage.trimRight(),
    );
    emit(
      state.copyWith(
        messages: List.of(state.messages!)..insert(0, textMessage),
        messageStatus: Status.loading,
      ),
    );
    final res = await sendMessage(
      MessageParam(
        content: event.textMessage,
        conversation: state.conversation,
        streamMessage: state.streamMessage,
      ),
    );

    res.fold(
      (l) {
        emit(
          state.copyWith(
            messageStatus: Status.failed,
            failure: l,
          ),
        );
      },
      (message) {
        if (message.response == null) {
          final idConversation = state.conversation?.id;
          if (idConversation != null) {
            return add(ChatMessageAnswerGot(conversationId: idConversation));
          } else {
            return emit(
              state.copyWith(
                messageStatus: Status.failed,
                failure: const ServerFailure(info: 'conversation introuvable'),
              ),
            );
          }
        }

        // going here if the message answer isn't stream
        final textMessage = types.TextMessage(
          author: state.receiver!,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: _randomString(),
          text: message.response?.trim() ?? '',
        );
        emit(
          state.copyWith(
            messages: List.of(state.messages!)..insert(0, textMessage),
            messageStatus: Status.init,
          ),
        );
      },
    );
  }

  void _onChatCategoriesFetched(
    ChatCategoriesFetched event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(catStatus: Status.loading));
    final res = await fetchCategories(NoParams());

    res.fold(
      (l) {
        emit(
          state.copyWith(
            catStatus: Status.failed,
            failure: l,
          ),
        );
      },
      (categories) => emit(
        state.copyWith(categories: categories, catStatus: Status.loaded),
      ),
    );
  }

  StreamTransformer<Uint8List, List<int>> unit8Transformer =
      StreamTransformer.fromHandlers(
    handleData: (data, sink) {
      sink.add(List<int>.from(data));
    },
  );

  String _randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
