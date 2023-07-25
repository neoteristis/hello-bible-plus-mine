// import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

// import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/extension/string_extension.dart';

// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logger/logger.dart';
import 'package:vibration/vibration.dart';
// import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/helper/custom_scroll_physics.dart';
import '../../../../../core/helper/log.dart';
import '../../../../../core/sse/sse.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

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
  final CancelMessageComingUsecase cancelMessageComing;
  late StreamSubscription<SseMessage> streamSubscription;

  ChatBloc({
    required this.fetchCategoriesBySection,
    required this.fetchCategories,
    required this.changeConversation,
    required this.sendMessage,
    required this.getResponseMessages,
    required this.getConversationById,
    required this.getSuggestionMessages,
    required this.cancelMessageComing,
  }) : super(
          ChatState(
            textEditingController: TextEditingController(),
            focusNode: FocusNode(),
            scrollController: ScrollController(),
            scrollPhysics: const PositionRetainedScrollPhysics(),
            containerKey: GlobalKey(),
            textFieldKey: GlobalKey(),
            listKey: GlobalKey(),
            chatKey: GlobalKey(),
          ),
        ) {
    on<ChatMessageSent>(_onChatMessageSent);
    on<ChatCategoriesBySectionFetched>(_onChatCategoriesBySectionFetched);
    on<ChatConversationChanged>(_onChatConversationChanged);
    on<ChatConversationCleared>(_onChatConversationCleared);
    on<ChatMessageAdded>(_onChatMessageAdded);
    on<ChatTypingStatusChanged>(_onChatTypingStatusChanged);
    on<ChatMessageJoined>(_onChatMessageJoined);
    on<ChatMessageAnswerGot>(
      _onChatMessageAnswerGot,
      transformer: restartable(),
    );
    on<ChatIncomingMessageLoaded>(_onChatIncomingMessageLoaded);
    on<ChatFocusNodeDisposed>(_onChatFocusNodeDisposed);
    on<ChatConversationInited>(_onChatConversationInited);
    // on<ChatConversationFromNotificationInited>(
    //     _onChatConversationFromNotificationInited);
    on<ChatSuggestionsRequested>(
      _onChatSuggestionsRequested,
      transformer: restartable(),
    );
    on<ChatLoadingChanged>(_onChatLoadingChanged);
    on<ChatUserTapChanged>(_onChatUserTapChanged);
    on<ChatFirstLaunchStateChanged>(_onChatFirstLaunchStateChanged);
    on<ChatStreamCanceled>(_onChatStreamCanceled);
    on<ChatVibrated>(_onChatVibrated);
    on<ChatAnswerRegenerated>(_onChatAnswerRegenerated);
    on<ChatSharingTextGenerated>(_onChatSharingTextGenerated);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onChatSharingTextGenerated(
    ChatSharingTextGenerated event,
    Emitter<ChatState> emit,
  ) {
    final List<String> sharingChat = [];
    final List<TextMessage> messages = List.of(state.messages ?? []);
    if (event.lastMessage != null) {
      messages.add(TextMessage(content: event.lastMessage, role: Role.system));
    }
    if (messages.isNotEmpty) {
      for (final chat in messages) {
        if (chat.role == Role.user) {
          sharingChat.add(
            'Moi : ${chat.content}',
          );
        } else {
          sharingChat.add(
            'Bot : ${chat.content}',
          );
        }
      }
      emit(
        state.copyWith(
          chatToShare: 'HelloBible+ \n\n${sharingChat.join('\n\n')}',
        ),
      );
    }
  }

  void _onChatAnswerRegenerated(
    ChatAnswerRegenerated event,
    Emitter<ChatState> emit,
  ) {
    state.scrollController?.jumpTo(
      state.scrollController!.position.maxScrollExtent,
      // duration: const Duration(milliseconds: 500),
      // curve: Curves.ease,
    );
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
          messageStatus: Status.loading,
        ),
      );
    }
    final id = state.conversation?.id;
    if (id != null) {
      add(
        ChatMessageAnswerGot(
          conversationId: id,
          messageId: event.messsageId != null ? event.messsageId! - 1 : null,
        ),
      );
    }
    if (event.messsageId != null) {
      emit(
        state.copyWith(
          messages: List.of(state.messages ?? [])
            ..removeRange(
              event.messsageId!,
              state.messages!.length - 1,
            ),
        ),
      );
    }
  }

  void _onChatVibrated(
    ChatVibrated event,
    Emitter<ChatState> emit,
  ) async {
    // if (await Vibration.hasVibrator() ?? false) {
    try {
      Vibration.vibrate(duration: 10, amplitude: -1);
    } catch (e) {}
// }
  }

  void _onChatStreamCanceled(
    ChatStreamCanceled event,
    Emitter<ChatState> emit,
  ) async {
    streamSubscription.cancel();
    add(
      const ChatLoadingChanged(
        false,
      ),
    );
    add(
      ChatMessageJoined(
        newMessage: state.incoming ?? '',
      ),
    );
    if (state.conversation != null && state.isLoading!) {
      cancelMessageComing(state.conversation!);
    }
  }

  void _onChatFirstLaunchStateChanged(
    ChatFirstLaunchStateChanged event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(firstLaunch: event.isFirstLaunch));
  }

  void _onChatUserTapChanged(
    ChatUserTapChanged event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(isUserTap: event.isUserTap));
  }

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
    final conversation = Conversation(
      id: historical.idString,
      category: categorySelected,
    );
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
    final res = await getResponseMessages(
      PGetResponseMessage(
        idConversation: event.conversationId,
        messageId: event.messageId,
      ),
    );
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
        add(const ChatUserTapChanged(false));
        print(rs.data);
        try {
          streamSubscription = rs.data?.stream
              .transform(unit8Transformer)
              .transform(const Utf8Decoder())
              .transform(const LineSplitter())
              .transform(const SseTransformer())
              .listen(
            (SseMessage sse) async {
              String trunck = '';

              if (sse.data.length > 1) {
                trunck = sse.data.substring(1);
              } else if (sse.data == ' ') {
                if (messageJoined[messageJoined.length - 1]
                    .contains(RegExp(r'[?!;.,]'))) {
                  trunck = '\n\n';
                } else if (messageJoined
                    .split('.')
                    .last
                    .hasUnclosedParenthesis) {
                  trunck = ').\n\n';
                } else if (messageJoined.hasUnclosedQuote) {
                  trunck = '".\n\n';
                } else {
                  trunck = '.\n\n';
                }
              } else {
                trunck = sse.data;
              }
              add(
                const ChatTypingStatusChanged(
                  isTyping: true,
                ),
              );
              if (trunck.contains(endMessageMarker)) {
                // debugPrint(messageJoined);
                // mark that the stream is finished
                add(
                  const ChatLoadingChanged(
                    false,
                  ),
                );
                add(
                  ChatMessageJoined(
                    newMessage: messageJoined,
                  ),
                );
                add(ChatSharingTextGenerated(lastMessage: messageJoined));
              }
              if (trunck != endMessageMarker) {
                add(
                  const ChatLoadingChanged(
                    true,
                  ),
                );
                state.textEditingController?.text =
                    '${state.textEditingController?.text}$trunck';

                messageJoined = '$messageJoined$trunck';
                add(
                  ChatIncomingMessageLoaded(
                    message: messageJoined,
                  ),
                );
              }
            },
          );
        } catch (e) {
          emit(
            state.copyWith(
              messageStatus: Status.failed,
              failure: ServerFailure(
                info: e.toString(),
              ),
            ),
          );
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
        conversation: Conversation(category: event.category),
        clearNewMessage: true,
        incoming: '',
        readOnly: false,
        firstLaunch: true,
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
        if (id != null && event.firstMessage == null) {
          // get the first default message and the suggestions message when the convesation is ready
          add(
            ChatMessageAnswerGot(conversationId: id),
          );
          add(
            ChatSuggestionsRequested(
              MessageParam(conversation: conversation),
            ),
          );
        } else if (event.firstMessage != null) {
          // final textAnswer = TextMessage(
          //   role: Role.user,
          //   createdAt: DateTime.now(),
          //   content: event.firstMessage ?? '',
          // );

          // emit(
          //   state.copyWith(
          //     messages: List.of(state.messages!)..add(textAnswer),
          //     messageStatus: Status.loading,
          //   ),
          // );
          add(ChatMessageSent(event.firstMessage ?? ''));
        }
      },
    );
  }

  void _onChatMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    // add(const ChatSuggestionViewChanged(false));

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
    // if (state.scrollController!.hasClients) {
    await Future.delayed(const Duration(milliseconds: 200));
    state.scrollController?.jumpTo(
      state.scrollController!.position.maxScrollExtent,
      // duration: const Duration(milliseconds: 500),
      // curve: Curves.ease,
    );
    // }
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

  @override
  Future<void> close() {
    if (state.scrollController != null) {
      state.scrollController!.dispose();
    }
    return super.close();
  }

  StreamTransformer<Uint8List, List<int>> unit8Transformer =
      StreamTransformer.fromHandlers(
    handleData: (data, sink) {
      sink.add(List<int>.from(data));
    },
  );
}
