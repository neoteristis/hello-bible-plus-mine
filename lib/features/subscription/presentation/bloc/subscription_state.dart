part of 'subscription_bloc.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.paymentData,
    this.paymentDataStatus = Status.init,
    this.failure,
    this.status = Status.init,
  });
  final PaymentData? paymentData;
  final Status? paymentDataStatus;
  final Failure? failure;
  final Status? status;

  @override
  List<Object?> get props => [
        paymentData,
        paymentDataStatus,
        failure,
        status,
      ];

  SubscriptionState copyWith({
    PaymentData? paymentData,
    Status? paymentDataStatus,
    Failure? failure,
    Status? status,
  }) {
    return SubscriptionState(
      paymentData: paymentData ?? this.paymentData,
      paymentDataStatus: paymentDataStatus ?? this.paymentDataStatus,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
