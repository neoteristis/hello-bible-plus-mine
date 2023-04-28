part of 'donation_bloc.dart';

abstract class DonationEvent extends Equatable {
  const DonationEvent();

  @override
  List<Object?> get props => [];
}

class DonationPageProgressed extends DonationEvent {
  final int? value;
  const DonationPageProgressed({
    this.value,
  });

  @override
  List<Object?> get props => [value];
}

class DonationPageLoaded extends DonationEvent {}

class DonationPageFailed extends DonationEvent {}
