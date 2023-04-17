part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.sender = const types.User(
      firstName: 'sender',
      id: 'sender_1',
    ),
    this.receiver = const types.User(
      firstName: 'receiver',
      id: 'receiver_1',
    ),
  });

  final List<types.Message>? messages;
  final types.User? sender;
  final types.User? receiver;

  @override
  List<Object?> get props => [
        messages,
        sender,
        receiver,
      ];

  ChatState copyWith({
    List<types.Message>? messages,
    types.User? sender,
    types.User? receiver,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
    );
  }
}
