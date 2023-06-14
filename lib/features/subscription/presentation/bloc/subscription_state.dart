part of 'subscription_bloc.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.paymentData,
    this.paymentDataStatus = Status.init,
    this.failure,
    this.status = Status.init,
    this.subscriptions = const [],
    this.code,
    this.checkCodeStatus = Status.init,
    this.invalidCode = false,
    this.buttonController,
    this.cancelSubscriptionStatus = Status.init,
  });
  final PaymentData? paymentData;
  final Status? paymentDataStatus;
  final Failure? failure;
  final Status? status;
  final List<SubscriptionType>? subscriptions;
  final String? code;
  final Status? checkCodeStatus;
  final bool? invalidCode;
  final RoundedLoadingButtonController? buttonController;
  final Status? cancelSubscriptionStatus;

  @override
  List<Object?> get props => [
        paymentData,
        paymentDataStatus,
        failure,
        status,
        subscriptions,
        code,
        checkCodeStatus,
        invalidCode,
        buttonController,
        cancelSubscriptionStatus,
      ];

  SubscriptionState copyWith({
    PaymentData? paymentData,
    Status? paymentDataStatus,
    Failure? failure,
    Status? status,
    List<SubscriptionType>? subscriptions,
    String? code,
    Status? checkCodeStatus,
    bool? invalidCode,
    RoundedLoadingButtonController? buttonController,
    Status? cancelSubscriptionStatus,
  }) {
    return SubscriptionState(
      paymentData: paymentData ?? this.paymentData,
      paymentDataStatus: paymentDataStatus ?? this.paymentDataStatus,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      subscriptions: subscriptions ?? this.subscriptions,
      code: code ?? this.code,
      checkCodeStatus: checkCodeStatus ?? this.checkCodeStatus,
      invalidCode: invalidCode ?? this.invalidCode,
      buttonController: buttonController ?? this.buttonController,
      cancelSubscriptionStatus:
          cancelSubscriptionStatus ?? this.cancelSubscriptionStatus,
    );
  }
}
