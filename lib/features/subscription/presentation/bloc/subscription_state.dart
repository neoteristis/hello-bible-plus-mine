part of 'subscription_bloc.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.paymentData,
    this.paymentDataStatus = Status.init,
    this.failure,
    this.status = Status.init,
    this.subscriptions = const [],
  });
  final PaymentData? paymentData;
  final Status? paymentDataStatus;
  final Failure? failure;
  final Status? status;
  final List<SubscriptionType>? subscriptions;

  @override
  List<Object?> get props => [
        paymentData,
        paymentDataStatus,
        failure,
        status,
        subscriptions,
      ];

  SubscriptionState copyWith({
    PaymentData? paymentData,
    Status? paymentDataStatus,
    Failure? failure,
    Status? status,
    List<SubscriptionType>? subscriptions,
  }) {
    return SubscriptionState(
      paymentData: paymentData ?? this.paymentData,
      paymentDataStatus: paymentDataStatus ?? this.paymentDataStatus,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      subscriptions: subscriptions ?? this.subscriptions,
    );
  }
}
