part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState(
      {this.registrationInputs = const RegistrationInputs()});

  final RegistrationInputs registrationInputs;

  @override
  List<Object?> get props => [registrationInputs];

  RegistrationState copyWith({
    RegistrationInputs? registrationInputs,
  }) {
    return RegistrationState(
      registrationInputs: registrationInputs ?? this.registrationInputs,
    );
  }
}

class RegistrationInputs with FormzMixin {
  const RegistrationInputs({
    this.name = const RequiredInput.pure(),
    this.firstname = const RequiredInput.pure(),
    this.email = const EmailInput.pure(),
    this.country = const RequiredInput.pure(),
    this.code = const RequiredInput.pure(),
  });

  final RequiredInput name;
  final RequiredInput firstname;
  final EmailInput email;
  final RequiredInput country;
  final RequiredInput code;

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
    RequiredInput? code,
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
