part of 'historical_bloc.dart';

class HistoricalState extends Equatable {
  const HistoricalState({
    this.status = Status.init,
    this.historicals,
    this.failure,
    this.scrollController,
    this.indexPage = 1,
    this.hasReachedMax = false,
    this.isRefresh = false,
  });

  final Status? status;
  final List<HistoricalConversation>? historicals;
  final Failure? failure;
  final ScrollController? scrollController;
  final int? indexPage;
  final bool? hasReachedMax;
  final bool? isRefresh;

  @override
  List<Object?> get props => [
        status,
        historicals,
        failure,
        scrollController,
        indexPage,
        hasReachedMax,
        isRefresh,
      ];

  HistoricalState copyWith({
    Status? status,
    List<HistoricalConversation>? historicals,
    Failure? failure,
    ScrollController? scrollController,
    int? indexPage,
    bool? hasReachedMax,
    bool? isRefresh,
  }) {
    return HistoricalState(
      status: status ?? this.status,
      historicals: historicals ?? this.historicals,
      failure: failure ?? this.failure,
      scrollController: scrollController ?? this.scrollController,
      indexPage: indexPage ?? this.indexPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }
}
