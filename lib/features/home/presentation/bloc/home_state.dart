part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<CategoriesBySection> categoriesBySection;
  final Status status;

  const HomeState({
    required this.categoriesBySection,
    required this.status,
  });

  HomeState copyWith({
    List<CategoriesBySection>? categoriesBySection,
    Status? status,
  }) {
    return HomeState(
      categoriesBySection: categoriesBySection ?? this.categoriesBySection,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [categoriesBySection, status];
}

class HomeInitial extends HomeState {
  const HomeInitial({
    super.categoriesBySection = const [],
    super.status = Status.init,
  });
}
