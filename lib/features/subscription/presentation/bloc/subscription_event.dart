part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class SubscriptionPaymentDataRequested extends SubscriptionEvent {
  final SubscriptionType subsriptionType;
  const SubscriptionPaymentDataRequested(
    this.subsriptionType,
  );
  @override
  List<Object> get props => [subsriptionType];
}

class SubscriptionPaymentSheetInited extends SubscriptionEvent {}

class SubscriptionPaymentSheetPresented extends SubscriptionEvent {}

class SubscriptionPaymentSheetConfirmed extends SubscriptionEvent {}

class SubscriptionFetched extends SubscriptionEvent {}

// class SubscriptionUpdated extends SubscriptionEvent {
//   final SubscriptionType subscription;
//   const SubscriptionUpdated({
//     required this.subscription,
//   });
//   @override
//   List<Object> get props => [subscription];
// }

class SubscriptionCodeChanged extends SubscriptionEvent {
  final String code;
  const SubscriptionCodeChanged(
    this.code,
  );

  @override
  List<Object> get props => [code];
}

class SubscriptionCodeChecked extends SubscriptionEvent {}

class SubscriptionCanceled extends SubscriptionEvent {}
