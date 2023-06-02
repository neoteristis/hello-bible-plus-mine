part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.registrationInputs = const RegistrationInputs(),
    this.registrationBtnController,
    this.status = Status.init,
  });

  final RegistrationInputs registrationInputs;
  final RoundedLoadingButtonController? registrationBtnController;
  final Status? status;

  @override
  List<Object?> get props => [
        registrationInputs,
        registrationBtnController,
        status,
      ];

  RegistrationState copyWith({
    RegistrationInputs? registrationInputs,
    RoundedLoadingButtonController? registrationBtnController,
    Status? status,
  }) {
    return RegistrationState(
      registrationInputs: registrationInputs ?? this.registrationInputs,
      registrationBtnController:
          registrationBtnController ?? this.registrationBtnController,
      status: status ?? this.status,
    );
  }
}

class RegistrationInputs with FormzMixin {
  const RegistrationInputs({
    this.name = const RequiredInput.pure(),
    this.firstname = const RequiredInput.pure(),
    this.email = const EmailInput.pure(),
    this.country = const RequiredInput.pure(),
    this.code = const UnrequiredInput.pure(),
  });

  final RequiredInput name;
  final RequiredInput firstname;
  final EmailInput email;
  final RequiredInput country;
  final UnrequiredInput code;

  @override
  List<FormzInput> get inputs => [
        name,
        firstname,
        email,
        country,
        code,
      ];

  RegistrationInputs copyWith({
    RequiredInput? name,
    FirstNameInput? firstname,
    EmailInput? email,
    RequiredInput? country,
    UnrequiredInput? code,
  }) {
    return RegistrationInputs(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      email: email ?? this.email,
      country: country ?? this.country,
      code: code ?? this.code,
    );
  }
}
