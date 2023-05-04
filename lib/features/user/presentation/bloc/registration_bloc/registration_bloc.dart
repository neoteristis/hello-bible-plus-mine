import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/helper/formz.dart';
import '../../../../../core/models/required_input.dart';
import '../../../data/models/email_input.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(const RegistrationState()) {
    on<RegistrationNameChanged>(_onRegistrationNameChanged);
    on<RegistrationFirstnameChanged>(_onRegistrationFirstnameChanged);
    on<RegistrationEmailChanged>(_onRegistrationEmailChanged);
    on<RegistrationCountryChanged>(_onRegistrationCountryChanged);
    on<RegistrationValidationCodeChanged>(_onRegistrationValidationCodeChanged);
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
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
      firstname: RequiredInput.dirty(
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
  ) {
    if (state.registrationInputs.isNotValid) {
      return;
    }
  }
}
