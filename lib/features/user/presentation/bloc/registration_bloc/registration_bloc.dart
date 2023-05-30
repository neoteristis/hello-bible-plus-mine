import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gpt/features/user/domain/entities/user.dart';
import 'package:gpt/features/user/domain/usecases/registration_usecase.dart';
import 'package:logger/logger.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/helper/formz.dart';
import '../../../../../core/models/required_input.dart';
import '../../../../../core/widgets/rounded_loading_button.dart';
import '../../../data/models/email_input.dart';
import '../../../data/models/first_name_input.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUsecase registration;
  RegistrationBloc({required this.registration})
      : super(RegistrationState(
            registrationBtnController: RoundedLoadingButtonController())) {
    on<RegistrationNameChanged>(_onRegistrationNameChanged);
    on<RegistrationFirstnameChanged>(_onRegistrationFirstnameChanged);
    on<RegistrationEmailChanged>(_onRegistrationEmailChanged);
    on<RegistrationCountryChanged>(_onRegistrationCountryChanged);
    on<RegistrationValidationCodeChanged>(_onRegistrationValidationCodeChanged);
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
    on<RegistrationTopicSubscribed>(_onRegistrationTopicSubscribed);
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
    final registrationInputs = state.registrationInputs.copyWith(
      name: RequiredInput.dirty(
        event.name,
      ),
    );
    emit(
      state.copyWith(
        registrationInputs: registrationInputs,
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
    final registrationInputs = state.registrationInputs.copyWith(
      email: EmailInput.dirty(
        event.email,
      ),
    );
    emit(
      state.copyWith(
        registrationInputs: registrationInputs,
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
      code: RequiredInput.dirty(
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
    if (state.registrationInputs.isNotValid) {
      checkEmptyError(emit);
      return;
    }
    state.registrationBtnController?.start();
    emit(state.copyWith(status: Status.loading));
    final inputs = state.registrationInputs;
    final deviceToken = await FirebaseMessaging.instance.getToken();

    final res = await registration(
      User(
        lastName: inputs.name.value,
        firstName: inputs.firstname.value,
        email: inputs.email.value,
        validationCode: inputs.code.value,
        country: inputs.country.value,
        deviceToken: deviceToken,
      ),
    );
    state.registrationBtnController?.stop();
    res.fold((l) {
      Logger().d(l);
      emit(state.copyWith(status: Status.failed));
    }, (user) {
      Logger().i('success $user');
      emit(
        state.copyWith(
          status: Status.loaded,
        ),
      );
      add(RegistrationTopicSubscribed(user: user));
    });
  }

  void checkEmptyError(Emitter<RegistrationState> emit) {
    state.registrationInputs.email.isPure
        ? emit(
            state.copyWith(
              registrationInputs: state.registrationInputs.copyWith(
                email: const EmailInput.dirty(
                  '',
                ),
              ),
            ),
          )
        : null;
    state.registrationInputs.name.isPure
        ? emit(
            state.copyWith(
              registrationInputs: state.registrationInputs.copyWith(
                name: const RequiredInput.dirty(
                  '',
                ),
              ),
            ),
          )
        : null;
    state.registrationInputs.firstname.isPure
        ? emit(
            state.copyWith(
              registrationInputs: state.registrationInputs.copyWith(
                firstname: const FirstNameInput.dirty(
                  '',
                ),
              ),
            ),
          )
        : null;
    state.registrationInputs.code.isPure
        ? emit(
            state.copyWith(
              registrationInputs: state.registrationInputs.copyWith(
                code: const RequiredInput.dirty(
                  '',
                ),
              ),
            ),
          )
        : null;
    state.registrationInputs.country.isPure
        ? emit(
            state.copyWith(
              registrationInputs: state.registrationInputs.copyWith(
                country: const RequiredInput.dirty(
                  '',
                ),
              ),
            ),
          )
        : null;
  }
}
