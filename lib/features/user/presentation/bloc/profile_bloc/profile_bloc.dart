import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/user/domain/usecases/usecases.dart';

import '../../../../../core/constants/status.dart';
import '../../../domain/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfile;
  ProfileBloc({
    required this.getProfile,
  }) : super(const ProfileState()) {
    on<ProfileStarted>(_onProfileStarted);
  }

  void _onProfileStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    final res = await getProfile(NoParams());
    return res.fold(
      (l) => emit(
        state.copyWith(
          status: Status.failed,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: Status.loaded,
          user: user,
        ),
      ),
    );
  }
}
