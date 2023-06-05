import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/features/subscription/domain/usecases/usecases.dart';
import 'package:logger/logger.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/widgets/rounded_loading_button.dart';
import '../../domain/entities/entities.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final PaymentIntentUsecase paymentIntent;
  final InitPaymentUsecase initPaymentSheet;
  final PresentPaymentUsecase presentPaymentSheet;
  final ConfirmPaymentUsecase confirmPaymentSheet;
  final FetchSubscriptionTypesUsecase fetchSubscriptions;
  final UpdateSubscriptionUsecase updateSubscription;
  final CheckCodeUsecase checkCode;
  SubscriptionBloc({
    required this.paymentIntent,
    required this.initPaymentSheet,
    required this.presentPaymentSheet,
    required this.confirmPaymentSheet,
    required this.fetchSubscriptions,
    required this.updateSubscription,
    required this.checkCode,
  }) : super(
          SubscriptionState(
            buttonController: RoundedLoadingButtonController(),
          ),
        ) {
    on<SubscriptionPaymentDataRequested>(_onSubscriptionPaymentDataRequested);
    on<SubscriptionPaymentSheetInited>(_onSubscriptionPaymentSheetInited);
    on<SubscriptionPaymentSheetPresented>(_onSubscriptionPaymentSheetPresented);
    on<SubscriptionPaymentSheetConfirmed>(_onSubscriptionPaymentSheetConfirmed);
    on<SubscriptionFetched>(_onSubscriptionFetched);
    on<SubscriptionUpdated>(_onSubscriptionUpdated);
    on<SubscriptionCodeChanged>(_onSubscriptionCodeChanged);
    on<SubscriptionCodeChecked>(_onSubscriptionCodeChecked);
  }

  void _onSubscriptionCodeChanged(
    SubscriptionCodeChanged event,
    Emitter<SubscriptionState> emit,
  ) {
    emit(
      state.copyWith(
        code: event.code,
      ),
    );
  }

  void _onSubscriptionCodeChecked(
    SubscriptionCodeChecked event,
    Emitter<SubscriptionState> emit,
  ) async {
    final code = state.code;
    if (code != null) {
      emit(
        state.copyWith(
          checkCodeStatus: Status.loading,
        ),
      );
      final res = await checkCode(code);
      return res.fold(
        (l) {
          bool invalidCode = false;
          if (l is NotFoundFailure) {
            invalidCode = true;
          }
          emit(
            state.copyWith(
              checkCodeStatus: Status.failed,
              failure: l,
              invalidCode: invalidCode,
            ),
          );
        },
        (r) => emit(
          state.copyWith(
            checkCodeStatus: Status.loaded,
            invalidCode: false,
          ),
        ),
      );
    }
    return emit(
      state.copyWith(
        invalidCode: true,
      ),
    );
  }

  void _onSubscriptionUpdated(
    SubscriptionUpdated event,
    Emitter<SubscriptionState> emit,
  ) async {
    final res = await updateSubscription(event.subscriptionId);

    return res.fold((l) => print('not updated'),
        (r) => add(SubscriptionPaymentDataRequested(1000)));
  }

  void _onSubscriptionFetched(
    SubscriptionFetched event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final res = await fetchSubscriptions(NoParams());
    return res.fold(
      (l) => emit(
        state.copyWith(
          status: Status.failed,
          failure: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: Status.loaded,
          subscriptions: r,
        ),
      ),
    );
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
