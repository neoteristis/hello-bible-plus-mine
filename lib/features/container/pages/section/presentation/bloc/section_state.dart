part of 'section_bloc.dart';

class SectionState extends Equatable {
  final Status? status;
  final List<WelcomeTheme>? welcomeThemes;

  const SectionState({
    this.status = Status.init,
    this.welcomeThemes = const [],
  });

  @override
  List<Object?> get props => [
        status,
        welcomeThemes,
      ];

  SectionState copyWith({
    Status? status,
    List<WelcomeTheme>? welcomeThemes,
  }) {
    return SectionState(
      status: status ?? this.status,
      welcomeThemes: welcomeThemes ?? this.welcomeThemes,
    );
  }
}
