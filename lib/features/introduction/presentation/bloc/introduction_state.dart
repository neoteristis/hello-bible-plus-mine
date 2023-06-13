part of 'introduction_bloc.dart';

class IntroductionState extends Equatable {
  const IntroductionState({
    this.controller,
    required this.currentPage,
  });

  final PageController? controller;
  final int currentPage;

  @override
  List<Object?> get props => [
        controller,
        currentPage,
      ];

  IntroductionState copyWith({
    PageController? controller,
    int? currentPage,
  }) {
    return IntroductionState(
      controller: controller ?? this.controller,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
