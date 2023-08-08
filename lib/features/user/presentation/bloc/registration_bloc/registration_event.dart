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

class RegistrationSubmitted extends RegistrationEvent {
  final BuildContext context;
  const RegistrationSubmitted(
    this.context,
  );

  @override
  List<Object?> get props => [context];
}

class RegistrationTopicSubscribed extends RegistrationEvent {
  final User user;
  const RegistrationTopicSubscribed({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class TakeImage extends RegistrationEvent {
  final ImageSource source;
  const TakeImage(
    this.source,
  );
  @override
  List<Object?> get props => [source];
}

class RegistrationEmailChecked extends RegistrationEvent {
  const RegistrationEmailChecked(
    this.email,
  );

  final String email;

  @override
  List<Object?> get props => [email];
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String password;
  const RegistrationPasswordChanged(
    this.password,
  );
  @override
  List<Object?> get props => [password];
}

class RegistrationConfirmPasswordChanged extends RegistrationEvent {
  final String confirmPassword;
  const RegistrationConfirmPasswordChanged(
    this.confirmPassword,
  );
  @override
  List<Object?> get props => [confirmPassword];
}

class RegistrationUserUpdated extends RegistrationEvent {}

class RegistrationPicturePicked extends RegistrationEvent {
  final ImageSource source;
  const RegistrationPicturePicked({
    required this.source,
  });

  @override
  List<Object?> get props => [
        source,
      ];
}
