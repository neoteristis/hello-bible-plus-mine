part of 'section_bloc.dart';

abstract class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object> get props => [];
}

class SectionWelcomThemeFetched extends SectionEvent {}

class SectionFirstMessageGot extends SectionEvent {
  final String conversationId;
  const SectionFirstMessageGot({
    required this.conversationId,
  });

  @override
  List<Object> get props => [conversationId];
}
