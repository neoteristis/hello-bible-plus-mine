part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class RegistrationNameChanged extends RegistrationEvent {
  final String name;
  const RegistrationNameChanged(
    this.name,
  );

  @override
  List<Object?> get props => [name];
}

class RegistrationFirstnameChanged extends RegistrationEvent {
  final String firstname;
  const RegistrationFirstnameChanged(
    this.firstname,
  );

  @override
  List<Object?> get props => [firstname];
}

class RegistrationEmailChanged extends RegistrationEvent {
  final String email;
  const RegistrationEmailChanged(
    this.email,
  );

  @override
  List<Object?> get props => [email];
}

class RegistrationCountryChanged extends RegistrationEvent {
  final String country;
  const RegistrationCountryChanged(
    this.country,
  );

  @override
  List<Object?> get props => [country];
}

class RegistrationValidationCodeChanged extends RegistrationEvent {
  final String code;
  const RegistrationValidationCodeChanged(
    this.code,
  );

  @override
  List<Object?> get props => [code];
}

class RegistrationSubmitted extends RegistrationEvent {}
