import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gpt/features/user/domain/entities/user.dart';
import 'package:gpt/l10n/function.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/helper/formz.dart';
import '../../../../../core/models/required_input.dart';
import '../../../../../core/models/unrequired_input.dart';
import '../../../../../core/widgets/rounded_loading_button.dart';
import '../../../data/models/email_input.dart';
import '../../../data/models/first_name_input.dart';
import '../../../domain/usecases/usecases.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUsecase registration;
  final CheckEmailUsecase checkEmail;
  final UpdateUserUsecase updateUser;
  final PickPictureUsecase pickPicture;

  RegistrationBloc({
    required this.registration,
    required this.checkEmail,
    required this.updateUser,
    required this.pickPicture,
  }) : super(
          RegistrationState(
            registrationBtnController: RoundedLoadingButtonController(),
            checkEmailBtnController: RoundedLoadingButtonController(),
            updateUserBtnController: RoundedLoadingButtonController(),
          ),
        ) {
    on<RegistrationNameChanged>(_onRegistrationNameChanged);
    on<RegistrationFirstnameChanged>(_onRegistrationFirstnameChanged);
    on<RegistrationEmailChanged>(_onRegistrationEmailChanged);
    on<RegistrationCountryChanged>(_onRegistrationCountryChanged);
    on<RegistrationValidationCodeChanged>(_onRegistrationValidationCodeChanged);
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
    on<RegistrationTopicSubscribed>(_onRegistrationTopicSubscribed);

    //new
    on<RegistrationEmailChecked>(_onRegistrationEmailChecked);
    on<RegistrationPasswordChanged>(_onRegistrationPasswordChanged);
    on<RegistrationConfirmPasswordChanged>(
        _onRegistrationConfirmPasswordChanged);
    on<RegistrationUserUpdated>(_onRegistrationUserUpdated);
    on<RegistrationPicturePicked>(_onRegistrationPicturePicked);
    on<TakeImage>(_onTakeImage);
  }

  void _onRegistrationPicturePicked(
    RegistrationPicturePicked event,
    Emitter<RegistrationState> emit,
  ) async {
    if (event.source == ImageSource.camera) {
      await _requestCameraPermission();
      final status = await Permission.camera.status;
      if (status.isGranted) {
        emit(
          state.copyWith(
            pickPictureStatus: Status.loading,
          ),
        );
        add(TakeImage(event.source));
      }
    } else if (event.source == ImageSource.gallery) {
      await _requestPhotoPermission();
      final status = await Permission.photos.status;
      if (status.isGranted) {
        emit(
          state.copyWith(
            pickPictureStatus: Status.loading,
          ),
        );
        add(TakeImage(event.source));
      }
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _requestPhotoPermission() async {
    final status = await Permission.photos.status;
    if (status.isDenied) {
      await Permission.photos.request();
    }
  }

  void _onTakeImage(
    TakeImage event,
    Emitter<RegistrationState> emit,
  ) async {
    final res = await pickPicture(event.source);
    return res.fold(
      (l) => emit(
        state.copyWith(
          pickPictureStatus: Status.failed,
          failure: l,
        ),
      ),
      (file) => emit(
        state.copyWith(
          image: file,
          pickPictureStatus: Status.loaded,
        ),
      ),
    );
  }

  void _onRegistrationUserUpdated(
    RegistrationUserUpdated event,
    Emitter<RegistrationState> emit,
  ) async {
    final name = state.name;
    if (name.isNotValid) {
      name.isPure
          ? emit(
              state.copyWith(
                name: const RequiredInput.dirty(
                  '',
                ),
              ),
            )
          : null;
      return;
    }
    state.updateUserBtnController?.start();
    emit(state.copyWith(updateStatus: Status.loading));
    final res = await updateUser(
      User(
        lastName: name.value,
        photo: state.image?.path,
      ),
    );
    state.updateUserBtnController?.stop();
    res.fold(
      (l) => emit(
        state.copyWith(
          updateStatus: Status.failed,
          failure: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          updateStatus: Status.loaded,
        ),
      ),
    );
  }

  void _onRegistrationEmailChecked(
    RegistrationEmailChecked event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(
      state.copyWith(
        email: EmailInput.dirty(
          event.email,
        ),
      ),
    );
    final email = state.email;
    if (email.isNotValid) {
      email.isPure
          ? emit(
              state.copyWith(
                email: const EmailInput.dirty(
                  '',
                ),
              ),
            )
          : null;
      return;
    }
    state.checkEmailBtnController?.start();
    emit(
      state.copyWith(
        emailCheckStatus: Status.loading,
      ),
    );

    final res = await checkEmail(email.value);
    state.checkEmailBtnController?.stop();
    return res.fold(
      (l) => emit(
        state.copyWith(
          emailCheckStatus: Status.failed,
          failure: l,
        ),
      ),
      (isEmailExist) {
        if (isEmailExist) {
          emit(state.copyWith(nextStep: Goto.login));
        } else {
          emit(state.copyWith(nextStep: Goto.registration));
        }
      },
    );
  }

  void _onRegistrationTopicSubscribed(
    RegistrationTopicSubscribed event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic('hello_bible_topic');
      // await FirebaseMessaging.instance.subscribeToTopic(
      //     'https://hellobox-api-test.my-preprod.space/${event.user.idString}');
    } catch (e) {
      Logger().w(e);
    }
  }

  void _onRegistrationNameChanged(
    RegistrationNameChanged event,
    Emitter<RegistrationState> emit,
  ) {
    print(event.name);
    emit(
      state.copyWith(
        name: RequiredInput.dirty(
          event.name,
        ),
      ),
    );
  }

  void _onRegistrationFirstnameChanged(
    RegistrationFirstnameChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final registrationInputs = state.registrationInputs.copyWith(
      firstname: FirstNameInput.dirty(
        event.firstname,
      ),
    );
    emit(
      state.copyWith(
        registrationInputs: registrationInputs,
      ),
    );
  }

  void _onRegistrationEmailChanged(
    RegistrationEmailChanged event,
    Emitter<RegistrationState> emit,
  ) {
    emit(
      state.copyWith(
        email: EmailInput.dirty(
          event.email,
        ),
      ),
    );
  }

  void _onRegistrationPasswordChanged(
    RegistrationPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    emit(
      state.copyWith(
        password: RequiredInput.dirty(
          event.password,
        ),
      ),
    );
  }

  void _onRegistrationConfirmPasswordChanged(
    RegistrationConfirmPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: RequiredInput.dirty(
          event.confirmPassword,
        ),
      ),
    );
  }

  void _onRegistrationCountryChanged(
    RegistrationCountryChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final registrationInputs = state.registrationInputs.copyWith(
      country: RequiredInput.dirty(
        event.country,
      ),
    );
    emit(
      state.copyWith(
        registrationInputs: registrationInputs,
      ),
    );
  }

  void _onRegistrationValidationCodeChanged(
    RegistrationValidationCodeChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final registrationInputs = state.registrationInputs.copyWith(
      code: UnrequiredInput.dirty(
        event.code,
      ),
    );
    emit(
      state.copyWith(
        registrationInputs: registrationInputs,
      ),
    );
  }

  void _onRegistrationSubmitted(
    RegistrationSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (state.password.isNotValid || state.confirmPassword.isNotValid) {
      checkEmptyError(emit);
      return;
    }
    final password = state.password.value;
    final confirmPassword = state.confirmPassword.value;
    if (confirmPassword != password) {
      return emit(
        state.copyWith(
          confirmPassordError: dict(event.context).passwordNotConfirmed,
        ),
      );
    }
    emit(state.copyWith(clearConfirmPasswordError: true));
    state.registrationBtnController?.start();
    emit(state.copyWith(status: Status.loading));

    // final deviceToken = await FirebaseMessaging.instance.getToken();

    final res = await registration(
      User(
        // lastName: inputs.name.value,
        // firstName: inputs.firstname.value,
        email: state.email.value,
        password: state.password.value,
        // validationCode: inputs.code.value,
        // country: inputs.country.value,
        // deviceToken: deviceToken,
      ),
    );
    state.registrationBtnController?.stop();
    res.fold((l) {
      emit(
        state.copyWith(
          status: Status.failed,
          failure: l,
        ),
      );
    }, (user) {
      emit(
        state.copyWith(
          status: Status.loaded,
        ),
      );
      add(
        RegistrationTopicSubscribed(
          user: user,
        ),
      );
    });
  }

  void checkEmptyError(Emitter<RegistrationState> emit) {
    // state.registrationInputs.email.isPure
    //     ? emit(
    //         state.copyWith(
    //           registrationInputs: state.registrationInputs.copyWith(
    //             email: const EmailInput.dirty(
    //               '',
    //             ),
    //           ),
    //         ),
    //       )
    //     : null;
    state.password.isPure
        ? emit(
            state.copyWith(
              password: const RequiredInput.dirty(
                '',
              ),
            ),
          )
        : null;
    state.confirmPassword.isPure
        ? emit(
            state.copyWith(confirmPassordError: 'Mot de passe non confirmé'),
          )
        : null;
    // state.registrationInputs.name.isPure
    //     ? emit(
    //         state.copyWith(
    //           registrationInputs: state.registrationInputs.copyWith(
    //             name: const RequiredInput.dirty(
    //               '',
    //             ),
    //           ),
    //         ),
    //       )
    //     : null;
    // state.registrationInputs.firstname.isPure
    //     ? emit(
    //         state.copyWith(
    //           registrationInputs: state.registrationInputs.copyWith(
    //             firstname: const FirstNameInput.dirty(
    //               '',
    //             ),
    //           ),
    //         ),
    //       )
    //     : null;
    // state.registrationInputs.code.isPure
    //     ? emit(
    //         state.copyWith(
    //           registrationInputs: state.registrationInputs.copyWith(
    //             code: const UnrequiredInput.dirty(
    //               '',
    //             ),
    //           ),
    //         ),
    //       )
    //     : null;
    // state.registrationInputs.country.isPure
    //     ? emit(
    //         state.copyWith(
    //           registrationInputs: state.registrationInputs.copyWith(
    //             country: const RequiredInput.dirty(
    //               '',
    //             ),
    //           ),
    //         ),
    //       )
    //     : null;
  }
}
