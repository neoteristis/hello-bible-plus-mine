part of 'introduction_bloc.dart';

abstract class IntroductionEvent extends Equatable {
  const IntroductionEvent();

  @override
  List<Object> get props => [];
}

class IntroductionContinueSubmitted extends IntroductionEvent {}

class IntroductionPageChanged extends IntroductionEvent {
  final int page;
  IntroductionPageChanged(
    this.page,
  );

  @override
  List<Object> get props => [page];
}

class IntroductionTerminated extends IntroductionEvent {}
