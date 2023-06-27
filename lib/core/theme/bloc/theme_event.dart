part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeStarted extends ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final BuildContext context;
  const ThemeChanged(
    this.context,
  );

  @override
  List<Object> get props => [context];
}
