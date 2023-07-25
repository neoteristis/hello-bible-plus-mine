import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/entities/pagination.dart';
import 'package:gpt/features/chat/domain/usecases/usecases.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/helper/is_bottom.dart';
import '../../../../../core/helper/throttle_droppable.dart';
import '../../../domain/entities/entities.dart';

part 'historical_event.dart';

part 'historical_state.dart';

class HistoricalBloc extends Bloc<HistoricalEvent, HistoricalState> {
  final FetchHistoricalUsecase fetchHistorical;

  HistoricalBloc({required this.fetchHistorical})
      : super(HistoricalState(scrollController: ScrollController())) {
    on<HistoricalFetched>(
      _onHistoricalFetched,
      transformer: throttleDroppable(),
    );
    on<HistoricalCleared>(_onHistoricalCleared);

    state.scrollController!.addListener(_onScroll);
  }

  void _onHistoricalCleared(
    HistoricalCleared event,
    Emitter<HistoricalState> emit,
  ) {
    emit(state.copyWith(historicals: []));
  }

  void _onHistoricalFetched(
    HistoricalFetched event,
    Emitter<HistoricalState> emit,
  ) async {
    if (state.hasReachedMax!) {
      return;
    }
    if (state.status == Status.init || event.isRefresh!) {
      emit(state.copyWith(status: Status.loading));
      event.isRefresh!
          ? emit(
              state.copyWith(
                isRefresh: true,
              ),
            )
          : null;
      final res = await fetchHistorical(
        const PHistorical(
          pagination: Pagination(page: 1),
        ),
      );
      return res.fold(
        (failure) => emit(
          state.copyWith(
            status: Status.failed,
            hasReachedMax: false,
            indexPage: 1,
            failure: failure,
            isRefresh: false,
          ),
        ),
        (loaded) => emit(
          state.copyWith(
            historicals: loaded,
            status: Status.loaded,
            hasReachedMax: false,
            indexPage: 1,
            isRefresh: false,
          ),
        ),
      );
    }

    emit(
      state.copyWith(
        indexPage: (state.indexPage! + 1),
      ),
    );

    final res = await fetchHistorical(
      PHistorical(
        pagination: Pagination(page: state.indexPage),
      ),
    );

    return res.fold(
        (failure) => emit(
              state.copyWith(
                status: Status.failed,
                failure: failure,
              ),
            ), (loaded) {
      if (loaded.isNotEmpty) {
        emit(
          state.copyWith(
            historicals: List.of(state.historicals!)..addAll(loaded),
            status: Status.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: Status.loaded,
            hasReachedMax: true,
          ),
        );
      }
    });

    // emit(state.copyWith(status: Status.loading));
    // final res = await fetchHistorical(const PHistorical());
    // return res.fold(
    //   (l) => emit(
    //     state.copyWith(
    //       status: Status.failed,
    //       failure: l,
    //     ),
    //   ),
    //   (historicals) => emit(
    //     state.copyWith(
    //       historicals: historicals,
    //       status: Status.loaded,
    //     ),
    //   ),
    // );
  }

  void _onScroll() {
    if (isBottom(scrollController: state.scrollController!)) {
      add(const HistoricalFetched());
    }
  }

  @override
  Future<void> close() {
    if (state.scrollController != null) {
      state.scrollController!
        ..removeListener(_onScroll)
        ..dispose();
    }
    return super.close();
  }
}
