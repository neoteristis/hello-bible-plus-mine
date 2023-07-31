import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/core/constants/status.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';

import '../../../../../../core/usecase/usecase.dart';
import '../../domain/usecases/fetch_categories_by_section.dart';
import '../../domain/usecases/fetch_categories_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCategoriesUsecase fetchCategories;
  final FetchCategoriesBySectionUsecase fetchCategoriesBySection;

  HomeBloc({
    required this.fetchCategoriesBySection,
    required this.fetchCategories,
  }) : super(const HomeInitial()) {
    on<ChatCategoriesBySectionFetched>(_onChatCategoriesBySectionFetched);
  }

  void _onChatCategoriesBySectionFetched(
    ChatCategoriesBySectionFetched event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final res = await fetchCategoriesBySection(NoParams());
    return res.fold(
      (l) {
        emit(
          state.copyWith(
            status: Status.failed,
          ),
        );
      },
      (categoriesBySection) => emit(
        state.copyWith(
          categoriesBySection: categoriesBySection,
          status: Status.loaded,
        ),
      ),
    );
  }
}
