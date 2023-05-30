part of 'subscription_bloc.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.paymentData,
    this.paymentDataStatus = Status.init,
  });
  final PaymentData? paymentData;
  final Status? paymentDataStatus;

  @override
  List<Object?> get props => [
        paymentData,
        paymentDataStatus,
      ];

  SubscriptionState copyWith({
    PaymentData? paymentData,
    Status? paymentDataStatus,
  }) {
    return SubscriptionState(
      paymentData: paymentData ?? this.paymentData,
      paymentDataStatus: paymentDataStatus ?? this.paymentDataStatus,
    );
  }
}
