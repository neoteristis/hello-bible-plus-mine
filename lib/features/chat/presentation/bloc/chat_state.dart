part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.sender = const types.User(
      firstName: 'sender',
      id: '82091008-a484-4a89-ae75-a22bf8d6f3hgf',
      imageUrl:
          'https://images.typeform.com/images/Va5mZpFZ4y2b/choice/thumbnail',
    ),
    this.receiver = const types.User(
      firstName: 'receiver',
      id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
      imageUrl:
          'https://images.typeform.com/images/Va5mZpFZ4y2b/choice/thumbnail',
    ),
    this.categories = const [],
    this.catStatus = Status.init,
    this.conversation,
    this.conversationStatus = Status.init,
  });

  final List<types.Message>? messages;
  final types.User? sender;
  final types.User? receiver;
  final List<Category>? categories;
  final Status? catStatus;
  final Conversation? conversation;
  final Status? conversationStatus;

  @override
  List<Object?> get props => [
        messages,
        sender,
        receiver,
        categories,
        catStatus,
        conversation,
        conversationStatus,
      ];

  ChatState copyWith({
    List<types.Message>? messages,
    types.User? sender,
    types.User? receiver,
    List<Category>? categories,
    Status? catStatus,
    Conversation? conversation,
    Status? conversationStatus,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      categories: categories ?? this.categories,
      catStatus: catStatus ?? this.catStatus,
      conversation: conversation ?? this.conversation,
      conversationStatus: conversationStatus ?? this.conversationStatus,
    );
  }
}
