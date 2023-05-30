import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/features/subscription/domain/usecases/payment_intent_usecase.dart';

import '../../../../core/constants/status.dart';
import '../../domain/entities/entities.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final PaymentIntentUsecase paymentIntent;
  SubscriptionBloc({
    required this.paymentIntent,
  }) : super(const SubscriptionState()) {
    on<SubscriptionPaymentDataRequested>(_onSubscriptionPaymentDataRequested);
  }
  void _onSubscriptionPaymentDataRequested(
    SubscriptionPaymentDataRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      state.copyWith(
        paymentDataStatus: Status.loading,
      ),
    );
    final res = await paymentIntent(PPayment(amount: event.amount));
    return res.fold(
      (l) => emit(
        state.copyWith(
          paymentDataStatus: Status.failed,
        ),
      ),
      (paymentData) => emit(
        state.copyWith(
          paymentData: paymentData,
          paymentDataStatus: Status.loaded,
        ),
      ),
    );
  }
}
