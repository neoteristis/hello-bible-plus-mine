// import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

// import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logger/logger.dart';
// import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/helper/custom_scroll_physics.dart';
import '../../../../core/helper/log.dart';
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
  final GetSuggestionsMessageUsecase getSuggestionMessages;
  // late StreamSubscription<String?> streamSubscription;
  ChatBloc({
    required this.fetchCategoriesBySection,
    required this.fetchCategories,
    required this.changeConversation,
    required this.sendMessage,
    required this.getResponseMessages,
    required this.getConversationById,
    required this.getSuggestionMessages,
  }) : super(
          ChatState(
            textEditingController: TextEditingController(),
            focusNode: FocusNode(),
            scrollController: ScrollController(),
            scrollPhysics: const PositionRetainedScrollPhysics(),
          ),
        ) {
    on<ChatMessageSent>(_onChatMessageSent);
    on<ChatCategoriesBySectionFetched>(_onChatCategoriesBySectionFetched);
    on<ChatConversationChanged>(_onChatConversationChanged);
    on<ChatConversationCleared>(_onChatConversationCleared);
    on<ChatMessageAdded>(_onChatMessageAdded);
    on<ChatTypingStatusChanged>(_onChatTypingStatusChanged);
    on<ChatMessageJoined>(_onChatMessageJoined);
    on<ChatMessageAnswerGot>(_onChatMessageAnswerGot);
    on<ChatIncomingMessageLoaded>(_onChatIncomingMessageLoaded);
    on<ChatFocusNodeDisposed>(_onChatFocusNodeDisposed);
    on<ChatConversationInited>(_onChatConversationInited);
    // on<ChatConversationFromNotificationInited>(
    //     _onChatConversationFromNotificationInited);
    on<ChatSuggestionsRequested>(_onChatSuggestionsRequested);
    on<ChatLoadingChanged>(_onChatLoadingChanged);
    // on<ChatScrollPhysicsSwitched>(_onChatScrollPhysicsSwitched);
    // on<ChatMaintainScrollChanged>(_onChatMaintainScrollChanged);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onChatLoadingChanged(
      ChatLoadingChanged event, Emitter<ChatState> emit) {
    emit(state.copyWith(isLoading: event.status));
  }

  void _onChatSuggestionsRequested(
    ChatSuggestionsRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        suggestions: [],
        suggestionLoaded: false,
      ),
    );
    final res = await getSuggestionMessages(event.message);
    return res.fold(
      (l) => Log.info(l),
      (suggestions) async {
        emit(
          state.copyWith(
            suggestions: suggestions,
          ),
        );
      },
    );
  }

  // void _onChatConversationFromNotificationInited(
  //   ChatConversationFromNotificationInited event,
  //   Emitter<ChatState> emit,
  // ) async {
  //   // state.textEditingController?.clear();
  //   // emit(
  //   //   state.copyWith(
  //   //     conversationStatus: Status.loading,
  //   //     conversation: const Conversation(),
  //   //     messages: [],
  //   //     clearNewMessage: true,
  //   //   ),
  //   // );
  //   // final res = await getConversationById(event.conversationId);

  //   // return res.fold(
  //   //   (l) => Logger().w(l),
  //   //   (conversation) {
  //   //     state.focusNode?.requestFocus();
  //   //     emit(
  //   //       state.copyWith(
  //   //         conversation: conversation,
  //   //         // theme: theme(conversation.category?.colorTheme),
  //   //         conversationStatus: Status.loaded,
  //   //       ),
  //   //     );
  //   //     final messages = conversation.messages;
  //   //     if (messages != null) {
  //   //       for (final message in messages) {
  //   //         final author =
  //   //             message.role == Role.user ? state.sender : state.receiver;
  //   //         final text = types.TextMessage(
  //   //           author: author!,
  //   //           createdAt: message.createdAt?.millisecondsSinceEpoch,
  //   //           id: _randomString(),
  //   //           text: message.content ?? '',
  //   //         );
  //   //         add(ChatMessageAdded(textMessage: text));
  //   //       }
  //   //     }
  //   //   },
  //   // );
  // }

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
        readOnly: true,
      ),
    );
    // state.focusNode?.requestFocus();
    Category? categorySelected;
    for (final CategoriesBySection catSection in state.categoriesBySection) {
      if (catSection.categories != null) {
        for (final Category category in catSection.categories!) {
          if (category.id == historical.category?.id) {
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
    // Log.info(historical.messages.length);
    for (final message in historical.messages) {
      // Log.info(message);
      // final role = message.role == Role.user ? Role : state.receiver;
      final text = TextMessage(
        role: message.role,
        createdAt: message.createdAt,
        content: message.content ?? '',
      );

      add(
        ChatMessageAdded(
          textMessage: message.content ?? '',
          createdAt: message.createdAt,
          role: message.role,
        ),
      );
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
      ),
      (rs) async {
        String messageJoined = '';

        try {
          rs.data?.stream
              .transform(unit8Transformer)
              .transform(const Utf8Decoder())
              .transform(const LineSplitter())
              .transform(const SseTransformer())
              .listen(
            (SseMessage event) async {
              // print(event.data);
              String trunck = '';

              if (event.data == ' ') {
                trunck = '.\n\n';
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
                // mark that the stream is finished
                add(
                  const ChatLoadingChanged(
                    false,
                  ),
                );

                // add(
                //   ChatIncomingMessageLoaded(
                //     message: messageJoined,
                //   ),
                // );
                add(
                  ChatMessageJoined(
                    newMessage: messageJoined,
                  ),
                );
              }
              if (trunck != endMessageMarker) {
                add(
                  const ChatLoadingChanged(
                    true,
                  ),
                );
                // add(
                //   const ChatScrollPhysicsSwitched(
                //     PositionRetainedScrollPhysics(),
                //   ),
                // );
                state.textEditingController?.text =
                    '${state.textEditingController?.text}$trunck';

                messageJoined = '$messageJoined$trunck';

                // maintain the emit of the new stream on the screen here if needed
                ///we maintain the scroll here for retain the automatic scroll when user scroll as the new message coming force the automatic scroll
                // if (state.maintainScroll == false) {
                add(
                  ChatIncomingMessageLoaded(
                    message: messageJoined,
                  ),
                );
                // }
              }
            },
          );
        } catch (e) {
          emit(state.copyWith(
              messageStatus: Status.failed,
              failure: ServerFailure(info: e.toString())));
        }
      },
    );
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
    // emit(state.copyWith(isTyping: event.isTyping));
  }

  void _onChatMessageAdded(
    ChatMessageAdded event,
    Emitter<ChatState> emit,
  ) {
    final textAnswer = event.textMessage;
    final textMessage = TextMessage(
      content: textAnswer,
      createdAt: event.createdAt ?? DateTime.now(),
      role: event.role ?? Role.user,
    );
    emit(
      state.copyWith(
        messages: List.of(state.messages!)..add(textMessage),
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
    emit(
      state.copyWith(
        clearConversation: true,
        suggestions: [],
        clearNewMessage: true,
      ),
    );
  }

  void _onChatConversationChanged(
    ChatConversationChanged event,
    Emitter<ChatState> emit,
  ) async {
    state.textEditingController?.clear();

    emit(
      state.copyWith(
        conversationStatus: Status.loading,
        // emit an empty conversation to go the chat screen
        conversation: const Conversation(),
        clearNewMessage: true,
        incoming: '',
        readOnly: false,
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
            //clear the empty conversation if any error occured, then the user will get back to the home screen
            clearConversation: true,
          ),
        );
      },
      (conversation) {
        emit(
          state.copyWith(
            conversation: conversation,
            conversationStatus: Status.loaded,
            messages: [],
          ),
        );
        final id = conversation.id;
        if (id != null) {
          // get the first default message and the suggestions message when the convesation is ready
          add(
            ChatMessageAnswerGot(
              conversationId: id,
            ),
          );
          add(
            ChatSuggestionsRequested(
              MessageParam(conversation: conversation),
            ),
          );
        }
      },
    );
  }

  void _onChatMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    // add(const ChatSuggestionViewChanged(false));
    if (state.scrollController!.hasClients) {
      state.scrollController?.jumpTo(
        state.scrollController!.position.maxScrollExtent,
        // duration: const Duration(milliseconds: 500),
        // curve: Curves.ease,
      );
    }

    if (state.newMessage != null) {
      /*
        the last message on the screen is still the customMessage build from the listbottomWidget,
        then you have to add the actual message here before inserting the new message from the user typing
      */

      //first clear the text controller

      state.textEditingController?.clear();
      final textAnswer = TextMessage(
        role: Role.system,
        createdAt: DateTime.now(),
        content: state.newMessage ?? '',
      );

      emit(
        state.copyWith(
          messages: List.of(state.messages!)..add(textAnswer),
          messageStatus: Status.init,
        ),
      );
    }
    final textMessage = TextMessage(
      role: Role.user,
      createdAt: DateTime.now(),
      content: event.textMessage.trimRight(),
    );
    emit(
      state.copyWith(
        messages: List.of(state.messages!)..add(textMessage),
        messageStatus: Status.loading,
      ),
    );
    final messageParams = MessageParam(
      content: event.textMessage,
      conversation: state.conversation,
    );

    add(
      ChatSuggestionsRequested(
        messageParams,
      ),
    );
    final res = await sendMessage(messageParams);

    return res.fold(
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

        // // going here if the message answer isn't stream ***** this functionnality has been removed
        // final textMessage = types.TextMessage(
        //   author: state.receiver!,
        //   createdAt: DateTime.now().millisecondsSinceEpoch,
        //   id: _randomString(),
        //   text: message.response?.trim() ?? '',
        // );
        // emit(
        //   state.copyWith(
        //     messages: List.of(state.messages!)..insert(0, textMessage),
        //     messageStatus: Status.init,
        //   ),
        // );
      },
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
