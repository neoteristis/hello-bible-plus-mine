import 'dart:convert';
import 'dart:math';

import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../core/constants/status.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/sse/sse.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchCategoriesUsecase fetchCategories;
  final ChangeConversationUsecase changeConversation;
  final SendMessagesUsecase sendMessage;
  final GetResponseMessagesUsecase getResponseMessages;
  late StreamSubscription<SseMessage>? streamSubscription;
  ChatBloc({
    required this.fetchCategories,
    required this.changeConversation,
    required this.sendMessage,
    required this.getResponseMessages,
  }) : super(
          ChatState(
            textEditingController: TextEditingController(),
          ),
        ) {
    on<ChatMessageSent>(_onChatMessageSent);
    on<ChatCategoriesFetched>(_onChatCategoriesFetched);
    on<ChatConversationChanged>(_onChatConversationChanged);
    on<ChatConversationCleared>(_onChatConversationCleared);
    on<ChatMessageAdded>(_onChatMessageAdded);
    on<ChatTypingStatusChanged>(_onChatTypingStatusChanged);
    on<ChatMessageJoined>(_onChatMessageJoined);
    on<ChatMessageAnswerGot>(_onChatMessageAnswerGot);
    on<ChatMessageModChanged>(_onChatMessageModChanged);
    on<ChatIncomingMessageLoaded>(_onChatIncomingMessageLoaded);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    final res = await getResponseMessages(event.messageId);
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
        streamSubscription = rs.data?.stream
            .transform(unit8Transformer)
            .transform(const Utf8Decoder())
            .transform(const LineSplitter())
            .transform(const SseTransformer())
            .listen((event) async {
          debugPrint(event.data);
          String trunck = '';
          if (event.data == ' ') {
            trunck = '\n';
          }
          if (event.data.length > 1) {
            trunck = event.data.substring(1);
          }
          add(const ChatTypingStatusChanged(
            isTyping: true,
          ));
          if (trunck == endMessageMarker) {
            debugPrint(messageJoined);
            streamSubscription?.cancel();
            add(ChatMessageJoined(newMessage: messageJoined));
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
        // clearNewMessage: event.clearMessage ?? false,
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
    emit(state.copyWith(
        conversationStatus: Status.loading,
        conversation: const Conversation()));
    final res = await changeConversation(event.category);
    res.fold(
      (l) {
        emit(state.copyWith(
            conversationStatus: Status.failed,
            failure: l,
            clearConversation: true));
      },
      (conversation) => emit(
        state.copyWith(
          conversation: conversation,
          theme: theme(event.category.colorTheme),
          conversationStatus: Status.loaded,
          messages: [],
        ),
      ),
    );
  }

  void _onChatMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    if (state.streamMessage! && state.messages!.isNotEmpty) {
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

      // then add the new message

      emit(
        state.copyWith(
          messages: List.of(state.messages!)..insert(0, textAnswer),
          messageStatus: Status.init,
        ),
      );
      // add(ChatMessageAdded(textMessage: textAnswer));
    }
    final textMessage = types.TextMessage(
      author: state.sender!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _randomString(),
      text: event.textMessage,
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
        emit(state.copyWith(messageStatus: Status.failed, failure: l));
      },
      (message) {
        if (message.response == null) {
          if (message.id != null) {
            return add(ChatMessageAnswerGot(messageId: message.id!));
          } else {
            return emit(
              state.copyWith(
                messageStatus: Status.failed,
                failure: const ServerFailure(info: 'conversation introuvable'),
              ),
            );
          }
        }
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
