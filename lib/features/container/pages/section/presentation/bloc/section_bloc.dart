import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/container/pages/section/domain/entities/welcome_theme.dart';

import '../../../../../../core/constants/status.dart';
import '../../domain/usecases/usecases.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final FetchWelcomeThemeUsecase fetchWelcomeTheme;
  SectionBloc({required this.fetchWelcomeTheme}) : super(const SectionState()) {
    on<SectionWelcomThemeFetched>(_onSectionWelcomThemeFetched);
  }

  void _onSectionWelcomThemeFetched(
    SectionWelcomThemeFetched event,
    Emitter<SectionState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final res = await fetchWelcomeTheme(NoParams());
    res.fold(
      (l) => emit(
        state.copyWith(
          status: Status.failed,
        ),
      ),
      (r) => emit(
        state.copyWith(
          welcomeThemes: r,
          status: Status.loaded,
        ),
      ),
    );
  }
}
