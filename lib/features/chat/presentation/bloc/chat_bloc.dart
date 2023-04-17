import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gpt/features/chat/domain/usecases/fetch_categories_usecase.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/category.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchCategoriesUsecase fetchCategories;
  ChatBloc({
    required this.fetchCategories,
  }) : super(const ChatState()) {
    on<ChatMessageSent>(_onChatMessageSent);
    on<ChatCategoriesFetched>(_onChatCategoriesFetched);
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
