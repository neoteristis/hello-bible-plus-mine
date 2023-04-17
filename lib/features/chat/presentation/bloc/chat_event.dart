part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatMessageSent extends ChatEvent {
  final types.PartialText message;
  const ChatMessageSent(this.message);
  @override
  List<Object> get props => [message];
}

class ChatCategoriesFetched extends ChatEvent {}

class ChatConversationChanged extends ChatEvent {
  final Category category;
  const ChatConversationChanged(
    this.category,
  );

  @override
  List<Object> get props => [category];
}

class ChatConversationCleared extends ChatEvent {}
