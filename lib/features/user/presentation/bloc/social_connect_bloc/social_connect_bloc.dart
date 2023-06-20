import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/core/usecase/usecase.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/widgets/rounded_loading_button.dart';
import '../../../domain/usecases/usecases.dart';

part 'social_connect_event.dart';
part 'social_connect_state.dart';

class SocialConnectBloc extends Bloc<SocialConnectEvent, SocialConnectState> {
  final SignInWithAppleUsecase signInWithApple;
  final SignInWithGoogleUsecase signInWithGoogle;
  SocialConnectBloc({
    required this.signInWithApple,
    required this.signInWithGoogle,
  }) : super(
          SocialConnectState(
            appleBtnController: RoundedLoadingButtonController(),
            googleBtnController: RoundedLoadingButtonController(),
            fbBtnController: RoundedLoadingButtonController(),
          ),
        ) {
    on<SocialConnectAppleSubmitted>(_onSocialConnectAppleSubmitted);
    on<SocialConnectGoogleSubmitted>(_onSocialConnectGoogleSubmitted);
  }

  void _onSocialConnectGoogleSubmitted(
    SocialConnectGoogleSubmitted event,
    Emitter<SocialConnectState> emit,
  ) async {
    if (state.status != Status.loading) {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );
      state.googleBtnController?.start();
      final res = await signInWithGoogle(NoParams());
      state.googleBtnController?.stop();
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
          ),
        ),
      );
    }
  }

  void _onSocialConnectAppleSubmitted(
    SocialConnectAppleSubmitted event,
    Emitter<SocialConnectState> emit,
  ) async {
    if (state.status != Status.loading) {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );
      state.appleBtnController?.start();
      final res = await signInWithApple(NoParams());
      state.appleBtnController?.stop();
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
          ),
        ),
      );
    }
  }
}
