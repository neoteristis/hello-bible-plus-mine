part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionPaymentDataRequested extends SubscriptionEvent {
  final double amount;
  const SubscriptionPaymentDataRequested(
    this.amount,
  );
  @override
  List<Object> get props => [amount];
}

class SubscriptionPaymentSheetInited extends SubscriptionEvent {}

class SubscriptionPaymentSheetPresented extends SubscriptionEvent {}

class SubscriptionPaymentSheetConfirmed extends SubscriptionEvent {}

class SubscriptionFetched extends SubscriptionEvent {}

class SubscriptionUpdated extends SubscriptionEvent {
  final String subscriptionId;
  const SubscriptionUpdated({
    required this.subscriptionId,
  });
  @override
  List<Object> get props => [subscriptionId];
}

class SubscriptionCodeChanged extends SubscriptionEvent {
  final String code;
  const SubscriptionCodeChanged(
    this.code,
  );

  @override
  List<Object> get props => [code];
}

class SubscriptionCodeChecked extends SubscriptionEvent {}
