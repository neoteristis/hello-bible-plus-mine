import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gpt/features/chat/domain/usecases/change_conversation_usecase.dart';
import 'package:gpt/features/chat/domain/usecases/fetch_categories_usecase.dart';
import 'package:gpt/features/chat/domain/usecases/send_messages_usecase.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/entities.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchCategoriesUsecase fetchCategories;
  final ChangeConversationUsecase changeConversation;
  final SendMessagesUsecase sendMessage;
  ChatBloc({
    required this.fetchCategories,
    required this.changeConversation,
    required this.sendMessage,
  }) : super(const ChatState()) {
    on<ChatMessageSent>(_onChatMessageSent);
    on<ChatCategoriesFetched>(_onChatCategoriesFetched);
    on<ChatConversationChanged>(_onChatConversationChanged);
    on<ChatConversationCleared>(_onChatConversationCleared);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    emit(state.copyWith(
        conversationStatus: Status.loading, conversation: Conversation()));
    final res = await changeConversation(event.category);
    res.fold(
      (l) {
        print(l);
        emit(state.copyWith(
            conversationStatus: Status.failed,
            failure: l,
            clearConversation: true));
      },
      (conversation) => emit(
        state.copyWith(
          conversation: conversation,
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
    final textMessage = types.TextMessage(
      author: state.sender!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _randomString(),
      text: event.message.text,
    );
    emit(
      state.copyWith(
        messages: List.of(state.messages!)..insert(0, textMessage),
        messageStatus: Status.loading,
      ),
    );
    final res = await sendMessage(MessageParam(
        content: event.message.text, conversation: state.conversation));

    res.fold(
      (l) {
        print(l);
        emit(state.copyWith(messageStatus: Status.failed, failure: l));
      },
      (message) {
        final textAnswer = types.TextMessage(
          author: state.receiver!,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: _randomString(),
          text: message.response ?? '',
        );
        emit(
          state.copyWith(
            messages: List.of(state.messages!)..insert(0, textAnswer),
            messageStatus: Status.loaded,
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
        print(l);
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

  String _randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
