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

class HistoricalDeleted extends HistoricalEvent {
  final HistoricalConversation historicalConversation;
  const HistoricalDeleted(
    this.historicalConversation,
  );

  @override
  List<Object?> get props => [historicalConversation];
}

class HistoricalEdited extends HistoricalEvent {
  final HistoricalConversation? historicalConversation;
  final String? title;
  const HistoricalEdited({
    this.historicalConversation,
    this.title,
  });

  @override
  List<Object?> get props => [
        historicalConversation,
        title,
      ];
}
