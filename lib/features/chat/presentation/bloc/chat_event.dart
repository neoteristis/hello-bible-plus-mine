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
