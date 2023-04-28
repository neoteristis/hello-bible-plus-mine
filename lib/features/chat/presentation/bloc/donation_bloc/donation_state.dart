part of 'donation_bloc.dart';

class DonationState extends Equatable {
  const DonationState({
    this.status,
    this.progressValue,
  });

  final Status? status;
  final int? progressValue;

  @override
  List<Object?> get props => [status, progressValue];

  DonationState copyWith({
    Status? status,
    int? progressValue,
  }) {
    return DonationState(
      status: status ?? this.status,
      progressValue: progressValue ?? this.progressValue,
    );
  }
}
