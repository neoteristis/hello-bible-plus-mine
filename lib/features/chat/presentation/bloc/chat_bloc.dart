import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<ChatMessageSent>(_onChatMessageSent);
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
      ),
    );
    await Future.delayed(Duration(seconds: 5));
    final textAnswer = types.TextMessage(
      author: state.receiver!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: _randomString(),
      text: 'hello there',
    );
    emit(state.copyWith(
        messages: List.of(state.messages ?? [])..insert(0, textAnswer)));
  }

  String _randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
