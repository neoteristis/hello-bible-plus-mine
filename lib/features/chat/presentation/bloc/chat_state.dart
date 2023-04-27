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
    this.messageStatus = Status.init,
    this.failure,
    this.textEditingController,
    this.isTyping = false,
    this.newMessage = '',
    this.theme,
    this.streamMessage = true,
  });

  final List<types.Message>? messages;
  final types.User? sender;
  final types.User? receiver;
  final List<Category>? categories;
  final Status? catStatus;
  final Conversation? conversation;
  final Status? conversationStatus;
  final Status? messageStatus;
  final Failure? failure;
  final TextEditingController? textEditingController;
  final bool? isTyping;
  final String? newMessage;
  final ThemeData? theme;
  final bool? streamMessage;

  @override
  List<Object?> get props => [
        newMessage,
        messages,
        sender,
        receiver,
        categories,
        catStatus,
        conversation,
        conversationStatus,
        messageStatus,
        failure,
        textEditingController,
        isTyping,
        theme,
        streamMessage,
      ];

  ChatState copyWith({
    List<types.Message>? messages,
    types.User? sender,
    types.User? receiver,
    List<Category>? categories,
    Status? catStatus,
    Conversation? conversation,
    bool clearConversation = false,
    Status? conversationStatus,
    Status? messageStatus,
    Failure? failure,
    TextEditingController? textEditingController,
    bool? isTyping,
    String? newMessage,
    bool clearNewMessage = false,
    ThemeData? theme,
    bool? streamMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      categories: categories ?? this.categories,
      catStatus: catStatus ?? this.catStatus,
      conversation:
          clearConversation ? null : conversation ?? this.conversation,
      conversationStatus: conversationStatus ?? this.conversationStatus,
      messageStatus: messageStatus ?? this.messageStatus,
      failure: failure ?? this.failure,
      textEditingController:
          textEditingController ?? this.textEditingController,
      isTyping: isTyping ?? this.isTyping,
      newMessage: clearNewMessage ? null : newMessage ?? this.newMessage,
      theme: theme ?? this.theme,
      streamMessage: streamMessage ?? this.streamMessage,
    );
  }
}
