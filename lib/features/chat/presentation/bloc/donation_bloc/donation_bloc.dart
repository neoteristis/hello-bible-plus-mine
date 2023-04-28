import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/status.dart';

part 'donation_event.dart';
part 'donation_state.dart';

class DonationBloc extends Bloc<DonationEvent, DonationState> {
  DonationBloc() : super(const DonationState()) {
    on<DonationPageProgressed>(_onDonationPageProgressed);
    on<DonationPageLoaded>(_onDonationPageLoaded);
    on<DonationPageFailed>(_onDonationPageFailed);
  }

  void _onDonationPageProgressed(
    DonationPageProgressed event,
    Emitter<DonationState> emit,
  ) {
    print('------------loading ${event.value}');
    emit(
      state.copyWith(
        status: Status.loading,
        progressValue: event.value,
      ),
    );
  }

  void _onDonationPageLoaded(
    DonationPageLoaded event,
    Emitter<DonationState> emit,
  ) {
    emit(state.copyWith(status: Status.loaded));
  }

  void _onDonationPageFailed(
    DonationPageFailed event,
    Emitter<DonationState> emit,
  ) {
    emit(state.copyWith(status: Status.failed));
  }
}
