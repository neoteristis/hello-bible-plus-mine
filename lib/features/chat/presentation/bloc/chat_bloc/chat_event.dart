part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatMessageSent extends ChatEvent {
  // final types.PartialText? message;
  final String textMessage;
  const ChatMessageSent(
    this.textMessage,
  );
  @override
  List<Object> get props => [
        textMessage,
      ];
}

class ChatSuggestionsRequested extends ChatEvent {
  // final types.PartialText? message;
  final MessageParam message;
  const ChatSuggestionsRequested(this.message);
  @override
  List<Object> get props => [message];
}

class ChatCategoriesBySectionFetched extends ChatEvent {}

class ChatConversationChanged extends ChatEvent {
  final Category category;
  final String? firstMessage;
  const ChatConversationChanged({
    required this.category,
    this.firstMessage,
  });

  @override
  List<Object?> get props => [
        category,
        firstMessage,
      ];
}

class ChatConversationCleared extends ChatEvent {}

class ChatMessageAdded extends ChatEvent {
  final String textMessage;
  final Role? role;
  final DateTime? createdAt;
  const ChatMessageAdded({
    required this.textMessage,
    this.role,
    this.createdAt,
  });
  @override
  List<Object?> get props => [
        textMessage,
        role,
        createdAt,
      ];
}

class ChatTypingStatusChanged extends ChatEvent {
  final bool isTyping;
  final bool? clearMessage;
  const ChatTypingStatusChanged({
    required this.isTyping,
    this.clearMessage = false,
  });
  @override
  List<Object?> get props => [
        isTyping,
        clearMessage,
      ];
}

class ChatMessageJoined extends ChatEvent {
  final String newMessage;
  const ChatMessageJoined({
    required this.newMessage,
  });
  @override
  List<Object> get props => [newMessage];
}

class ChatMessageAnswerGot extends ChatEvent {
  final String conversationId;
  final int? messageId;
  const ChatMessageAnswerGot({
    required this.conversationId,
    this.messageId,
  });

  @override
  List<Object?> get props => [
        conversationId,
        messageId,
      ];
}

class ChatMessageModChanged extends ChatEvent {
  final bool value;
  const ChatMessageModChanged({
    required this.value,
  });

  @override
  List<Object> get props => [value];
}

class ChatIncomingMessageLoaded extends ChatEvent {
  final String message;
  const ChatIncomingMessageLoaded({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class ChatFocusNodeDisposed extends ChatEvent {}

class ChatConversationInited extends ChatEvent {
  final HistoricalConversation historical;
  const ChatConversationInited({
    required this.historical,
  });

  @override
  List<Object> get props => [historical];
}

class ChatConversationFromNotificationInited extends ChatEvent {
  final String conversationId;
  const ChatConversationFromNotificationInited(
    this.conversationId,
  );

  @override
  List<Object> get props => [conversationId];
}

class ChatLoadingChanged extends ChatEvent {
  final bool status;
  const ChatLoadingChanged(
    this.status,
  );

  @override
  List<Object> get props => [status];
}

class ChatStreamCanceled extends ChatEvent {}

class ChatFirstLaunchStateChanged extends ChatEvent {
  final bool isFirstLaunch;
  const ChatFirstLaunchStateChanged({
    required this.isFirstLaunch,
  });

  @override
  List<Object> get props => [isFirstLaunch];
}

class ChatVibrated extends ChatEvent {}

// class ChatScrollPhysicsSwitched extends ChatEvent {
//   final ScrollPhysics physics;
//   final bool? addTimer;
//   const ChatScrollPhysicsSwitched(this.physics, {this.addTimer});

//   @override
//   List<Object?> get props => [
//         physics,
//         addTimer,
//       ];
// }

class ChatUserTapChanged extends ChatEvent {
  final bool isUserTap;
  const ChatUserTapChanged(
    this.isUserTap,
  );

  @override
  List<Object> get props => [
        isUserTap,
      ];
}

class ChatAnswerRegenerated extends ChatEvent {
  final int? messsageId;
  const ChatAnswerRegenerated({
    this.messsageId,
  });
  @override
  List<Object?> get props => [
        messsageId,
      ];
}

class ChatSharingTextGenerated extends ChatEvent {
  final String? lastMessage;
  const ChatSharingTextGenerated({
    this.lastMessage,
  });
  @override
  List<Object?> get props => [
        lastMessage,
      ];
}
