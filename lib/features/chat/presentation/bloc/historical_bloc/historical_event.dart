part of 'historical_bloc.dart';

abstract class HistoricalEvent extends Equatable {
  const HistoricalEvent();

  @override
  List<Object?> get props => [];
}

class HistoricalFetched extends HistoricalEvent {
  final bool? isRefresh;
  const HistoricalFetched({
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [isRefresh];
}

class HistoricalCleared extends HistoricalEvent {}
