import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/features/home/domain/usecases/fetch_categories_by_section.dart';
import 'package:gpt/features/home/domain/usecases/fetch_categories_usecase.dart';

import '../../../chat/domain/entities/entities.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCategoriesUsecase fetchCategories;
  final FetchCategoriesBySectionUsecase fetchCategoriesBySection;

  HomeBloc({
    required this.fetchCategoriesBySection,
    required this.fetchCategories,
  }) : super(HomeInitial()) {
    on<ChatCategoriesBySectionFetched>(_onChatCategoriesBySectionFetched);
  }
}
