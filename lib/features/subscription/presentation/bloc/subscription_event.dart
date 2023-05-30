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
