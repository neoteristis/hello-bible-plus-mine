import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/features/subscription/domain/usecases/payment_intent_usecase.dart';
import 'package:gpt/features/subscription/domain/usecases/usecases.dart';
import 'package:logger/logger.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/entities.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final PaymentIntentUsecase paymentIntent;
  final InitPaymentUsecase initPaymentSheet;
  final PresentPaymentUsecase presentPaymentSheet;
  final ConfirmPaymentUsecase confirmPaymentSheet;
  SubscriptionBloc({
    required this.paymentIntent,
    required this.initPaymentSheet,
    required this.presentPaymentSheet,
    required this.confirmPaymentSheet,
  }) : super(const SubscriptionState()) {
    on<SubscriptionPaymentDataRequested>(_onSubscriptionPaymentDataRequested);
    on<SubscriptionPaymentSheetInited>(_onSubscriptionPaymentSheetInited);
    on<SubscriptionPaymentSheetPresented>(_onSubscriptionPaymentSheetPresented);
    on<SubscriptionPaymentSheetConfirmed>(_onSubscriptionPaymentSheetConfirmed);
  }

  void _onSubscriptionPaymentSheetConfirmed(
    SubscriptionPaymentSheetConfirmed event,
    Emitter<SubscriptionState> emit,
  ) async {
    final res = await confirmPaymentSheet(NoParams());
    return res.fold(
      (l) => emit(state.copyWith(failure: l, status: Status.failed)),
      (r) => Logger().i('sucess confirm'),
    );
  }

  void _onSubscriptionPaymentSheetInited(
    SubscriptionPaymentSheetInited event,
    Emitter<SubscriptionState> emit,
  ) async {
    final paymentData = state.paymentData;
    if (paymentData != null) {
      final res = await initPaymentSheet(paymentData);
      return res.fold(
        (l) => emit(state.copyWith(failure: l, status: Status.failed)),
        (r) => add(
          SubscriptionPaymentSheetPresented(),
        ),
      );
    }
  }

  void _onSubscriptionPaymentSheetPresented(
    SubscriptionPaymentSheetPresented event,
    Emitter<SubscriptionState> emit,
  ) async {
    final res = await presentPaymentSheet(NoParams());
    return res.fold(
      (l) => emit(state.copyWith(failure: l, status: Status.failed)),
      (r) => Logger().i('sucess'),
    );
  }

  void _onSubscriptionPaymentDataRequested(
    SubscriptionPaymentDataRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    final res = await paymentIntent(PPayment(amount: event.amount));
    return res.fold(
      (l) => emit(
        state.copyWith(
          status: Status.failed,
        ),
      ),
      (paymentData) {
        emit(
          state.copyWith(
            paymentData: paymentData,
            // status: Status.loaded,
          ),
        );
        add(SubscriptionPaymentSheetInited());
      },
    );
  }
}
