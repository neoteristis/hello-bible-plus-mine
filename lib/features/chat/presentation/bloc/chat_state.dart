part of 'chat_bloc.dart';

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    // this.sender = const types.User(
    //   firstName: 'sender',
    //   id: '82091008-a484-4a89-ae75-a22bf8d6f3hgf',
    //   // imageUrl:
    //   //     'https://images.typeform.com/images/Va5mZpFZ4y2b/choice/thumbnail',
    // ),
    // this.receiver = const types.User(
    //   firstName: 'receiver',
    //   id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
    //   // imageUrl:
    //   //     'https://images.typeform.com/images/Va5mZpFZ4y2b/choice/thumbnail',
    // ),
    this.categories = const [],
    this.categoriesBySection = const [],
    this.catStatus = Status.init,
    this.conversation,
    this.conversationStatus = Status.init,
    this.messageStatus = Status.init,
    this.failure,
    this.textEditingController,
    this.isTyping = false,
    this.newMessage = '',
    this.theme,
    this.incoming = '',
    this.focusNode,
    this.suggestions = const [],
    this.scrollController,
    this.isLoading = false,
    this.showSuggestions = false,
    this.scrollPhysics,
    this.maintainScroll = false,
    this.suggestionLoaded = false,
    // this.chatObserver,
  });

  final List<TextMessage>? messages;
  // final User? sender;
  // final User? receiver;
  final List<Category>? categories;
  final List<CategoriesBySection> categoriesBySection;
  final Status? catStatus;
  final Conversation? conversation;
  final Status? conversationStatus;
  final Status? messageStatus;
  final Failure? failure;
  final TextEditingController? textEditingController;
  final bool? isTyping;
  final String? newMessage;
  final ThemeData? theme;
  final String? incoming;
  final FocusNode? focusNode;
  final List<String>? suggestions;
  final ScrollController? scrollController;
  final bool? isLoading;
  final bool? showSuggestions;
  final ScrollPhysics? scrollPhysics;
  final bool? maintainScroll;
  final bool? suggestionLoaded;
  // final List<String>
  // final ChatScrollObserver? chatObserver;

  @override
  List<Object?> get props => [
        // chatObserver,
        suggestionLoaded,
        categoriesBySection,
        newMessage,
        messages,
        // sender,
        // receiver,
        categories,
        catStatus,
        conversation,
        conversationStatus,
        messageStatus,
        failure,
        textEditingController,
        isTyping,
        theme,
        incoming,
        focusNode,
        suggestions,
        scrollController,
        isLoading,
        showSuggestions,
        scrollPhysics,
        maintainScroll,
      ];

  ChatState copyWith({
    List<TextMessage>? messages,
    // types.User? sender,
    // types.User? receiver,
    List<Category>? categories,
    List<CategoriesBySection>? categoriesBySection,
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
    String? incoming,
    FocusNode? focusNode,
    List<String>? suggestions,
    ScrollController? scrollController,
    bool? isLoading,
    bool? showSuggestions,
    ScrollPhysics? scrollPhysics,
    bool clearScrollPhysics = false,
    bool? maintainScroll,
    bool? suggestionLoaded,
    // ChatScrollObserver? chatObserver,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      // sender: sender ?? this.sender,
      // receiver: receiver ?? this.receiver,
      categories: categories ?? this.categories,
      categoriesBySection: categoriesBySection ?? this.categoriesBySection,
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
      incoming: incoming ?? this.incoming,
      focusNode: focusNode ?? this.focusNode,
      suggestions: suggestions ?? this.suggestions,
      scrollController: scrollController ?? this.scrollController,
      isLoading: isLoading ?? this.isLoading,
      showSuggestions: showSuggestions ?? this.showSuggestions,
      scrollPhysics:
          clearScrollPhysics ? null : scrollPhysics ?? this.scrollPhysics,
      maintainScroll: maintainScroll ?? this.maintainScroll,
      suggestionLoaded: suggestionLoaded ?? this.suggestionLoaded,
      // chatObserver: chatObserver ?? this.chatObserver,
    );
  }
}
