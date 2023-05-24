part of 'historical_bloc.dart';

class HistoricalState extends Equatable {
  const HistoricalState({
    this.status = Status.init,
    this.historicals,
    this.failure,
  });

  final Status? status;
  final List<HistoricalConversation>? historicals;
  final Failure? failure;

  @override
  List<Object?> get props => [
        status,
        historicals,
        failure,
      ];

  HistoricalState copyWith({
    Status? status,
    List<HistoricalConversation>? historicals,
    Failure? failure,
  }) {
    return HistoricalState(
      status: status ?? this.status,
      historicals: historicals ?? this.historicals,
      failure: failure ?? this.failure,
    );
  }
}
