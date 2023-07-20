part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatMessageSent extends ChatEvent {
  // final types.PartialText? message;
  final String textMessage;
  final BuildContext context;
  const ChatMessageSent(this.textMessage, this.context);
  @override
  List<Object> get props => [
        textMessage,
        context,
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
  final BuildContext context;
  const ChatConversationChanged(
    this.category,
    this.context,
  );

  @override
  List<Object> get props => [
        category,
        context,
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
  final BuildContext context;
  const ChatMessageAnswerGot({
    required this.conversationId,
    required this.context,
  });

  @override
  List<Object> get props => [
        conversationId,
        context,
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

class ChatStramCanceled extends ChatEvent {}

class ChatFirstLaunchStateChanged extends ChatEvent {
  final bool isFirstLaunch;
  const ChatFirstLaunchStateChanged({
    required this.isFirstLaunch,
  });

  @override
  List<Object> get props => [isFirstLaunch];
}

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
