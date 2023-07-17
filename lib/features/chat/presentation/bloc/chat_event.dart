part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatMessageSent extends ChatEvent {
  // final types.PartialText? message;
  final String textMessage;
  const ChatMessageSent(this.textMessage);
  @override
  List<Object> get props => [textMessage];
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
  const ChatConversationChanged(
    this.category,
  );

  @override
  List<Object> get props => [category];
}

class ChatConversationCleared extends ChatEvent {}

class ChatMessageAdded extends ChatEvent {
  final String textMessage;
  const ChatMessageAdded({
    required this.textMessage,
  });
  @override
  List<Object> get props => [textMessage];
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
  const ChatMessageAnswerGot({
    required this.conversationId,
  });

  @override
  List<Object> get props => [conversationId];
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

// class ChatFirstLaunchStateChanged extends ChatEvent {
//   final bool isFirstLaunch;
//   const ChatFirstLaunchStateChanged({
//     required this.isFirstLaunch,
//   });

//   @override
//   List<Object> get props => [isFirstLaunch];
// }

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

class ChatMaintainScrollChanged extends ChatEvent {
  final bool maintainScroll;
  const ChatMaintainScrollChanged(
    this.maintainScroll,
  );

  @override
  List<Object> get props => [
        maintainScroll,
      ];
}
