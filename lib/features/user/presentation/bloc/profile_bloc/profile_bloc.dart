import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/user/domain/usecases/usecases.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/helper/formz.dart';
import '../../../../../core/models/required_input.dart';
import '../../../../../core/widgets/rounded_loading_button.dart';
import '../../../data/models/email_input.dart';
import '../../../data/models/number_input.dart';
import '../../../domain/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfile;
  final UpdateUserUsecase updateUser;
  final PickPictureUsecase pickPicture;
  ProfileBloc({
    required this.getProfile,
    required this.updateUser,
    required this.pickPicture,
  }) : super(
          ProfileState(
            nameController: TextEditingController(),
            emailController: TextEditingController(),
            phoneController: TextEditingController(),
            buttonController: RoundedLoadingButtonController(),
            inputs: const ProfileInputs(),
          ),
        ) {
    on<ProfileStarted>(_onProfileStarted);
    on<ProfileUpdated>(_onProfileUpdated);
    on<ProfileUpdateStarted>(_onProfileUpdateStarted);
    on<ProfilePicturePicked>(_onProfilePicturePicked);
    on<ProfilePictureUpdated>(_onProfilePictureUpdated);
    on<ProfilePhoneChanged>(_onProfilePhoneChanged);
    on<ProfileEmailChanged>(_onProfileEmailChanged);
    on<ProfileNameChanged>(_onProfileNameChanged);
  }

  void _onProfileNameChanged(
    ProfileNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    final profileInputs = state.inputs?.copyWith(
      name: RequiredInput.dirty(
        event.name,
      ),
    );
    emit(
      state.copyWith(
        inputs: profileInputs,
      ),
    );
  }

  void _onProfileEmailChanged(
    ProfileEmailChanged event,
    Emitter<ProfileState> emit,
  ) {
    final profileInputs = state.inputs?.copyWith(
      email: EmailInput.dirty(
        event.email,
      ),
    );
    emit(
      state.copyWith(
        inputs: profileInputs,
      ),
    );
  }

  void _onProfilePhoneChanged(
    ProfilePhoneChanged event,
    Emitter<ProfileState> emit,
  ) {
    final profileInputs = state.inputs?.copyWith(
      phone: NumberInput.dirty(
        event.phone,
      ),
    );
    emit(
      state.copyWith(
        inputs: profileInputs,
      ),
    );
  }

  void _onProfilePictureUpdated(
    ProfilePictureUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(updatePictureStatus: Status.loading));
    final res = await updateUser(User(photo: event.path));
    return res.fold(
      (l) => emit(
        state.copyWith(
          failure: l,
          updatePictureStatus: Status.failed,
        ),
      ),
      (user) => emit(
        state.copyWith(
          user: user,
          updatePictureStatus: Status.loaded,
        ),
      ),
    );
  }

  void _onProfilePicturePicked(
    ProfilePicturePicked event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await pickPicture(event.source);
    res.fold(
      (l) => emit(
        state.copyWith(
          failure: l,
        ),
      ),
      (file) {
        emit(
          state.copyWith(
            image: file,
          ),
        );
        add(ProfilePictureUpdated(file?.path));
      },
    );
  }

  void _onProfileUpdateStarted(
    ProfileUpdateStarted event,
    Emitter<ProfileState> emit,
  ) async {
    final user = state.user;
    final name = user?.lastName;
    final email = user?.email;
    final phone = user?.phone;
    state.nameController?.text = name ?? '';
    state.emailController?.text = email ?? '';
    state.phoneController?.text = phone ?? '';
    add(ProfileNameChanged(name ?? ''));
    add(ProfileEmailChanged(email ?? ''));
    add(ProfilePhoneChanged(phone ?? ''));
  }

  void _onProfileUpdated(
    ProfileUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.inputs.isNotValid) {
      checkForEmptyError(emit);
      return print('-------invalid');
    }
    state.buttonController?.start();
    emit(state.copyWith(updateStatus: Status.loading));
    final res = await updateUser(
      User(
        lastName: state.inputs.name.value,
        email: state.inputs.email.value,
        phone: state.inputs.phone.value,
      ),
    );
    state.buttonController?.stop();
    return res.fold(
      (l) => emit(
        state.copyWith(
          updateStatus: Status.failed,
          failure: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          user: r,
          updateStatus: Status.loaded,
        ),
      ),
    );
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
      (user) {
        emit(
          state.copyWith(
            status: Status.loaded,
            user: user,
          ),
        );
        add(ProfileUpdateStarted());
      },
    );
  }

  void checkForEmptyError(Emitter<ProfileState> emit) {
    state.inputs.email.isPure
        ? emit(
            state.copyWith(
              inputs: state.inputs.copyWith(
                email: const EmailInput.dirty(
                  '',
                ),
              ),
            ),
          )
        : null;
    state.inputs.name.isPure
        ? emit(
            state.copyWith(
              inputs: state.inputs.copyWith(
                name: const RequiredInput.dirty(
                  '',
                ),
              ),
            ),
          )
        : null;
  }
}
