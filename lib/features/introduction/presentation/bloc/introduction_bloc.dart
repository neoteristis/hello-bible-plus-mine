import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/db_services/db_services.dart';

part 'introduction_event.dart';
part 'introduction_state.dart';

class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  final DbService db;
  IntroductionBloc({required this.db})
      : super(
          IntroductionState(
            currentPage: 0,
            controller: PageController(),
          ),
        ) {
    on<IntroductionContinueSubmitted>(_onIntroductionContinueSubmitted);
    on<IntroductionPageChanged>(_onIntroductionPageChanged);
    on<IntroductionTerminated>(_onIntroductionTerminated);
  }

  void _onIntroductionTerminated(
    IntroductionTerminated event,
    Emitter<IntroductionState> emit,
  ) async {
    await db.saveLaunchState();
  }

  void _onIntroductionPageChanged(
    IntroductionPageChanged event,
    Emitter<IntroductionState> emit,
  ) {
    emit(state.copyWith(currentPage: event.page));
  }

  void _onIntroductionContinueSubmitted(
    IntroductionContinueSubmitted event,
    Emitter<IntroductionState> emit,
  ) {
    final page = state.currentPage + 1;
    if (page < 3) {
      state.controller?.animateToPage(page,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      add(IntroductionPageChanged(page));
    }
  }
}
