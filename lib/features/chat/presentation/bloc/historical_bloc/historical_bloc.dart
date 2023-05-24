import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/features/chat/domain/usecases/usecases.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/entities/entities.dart';

part 'historical_event.dart';
part 'historical_state.dart';

class HistoricalBloc extends Bloc<HistoricalEvent, HistoricalState> {
  final FetchHistoricalUsecase fetchHistorical;
  HistoricalBloc({required this.fetchHistorical})
      : super(const HistoricalState()) {
    on<HistoricalFetched>(_onHistoricalFetched);
  }

  void _onHistoricalFetched(
    HistoricalFetched event,
    Emitter<HistoricalState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final res = await fetchHistorical(const PHistorical());
    return res.fold(
      (l) => emit(
        state.copyWith(
          status: Status.failed,
          failure: l,
        ),
      ),
      (historicals) => emit(
        state.copyWith(
          historicals: historicals,
          status: Status.loaded,
        ),
      ),
    );
  }
}
