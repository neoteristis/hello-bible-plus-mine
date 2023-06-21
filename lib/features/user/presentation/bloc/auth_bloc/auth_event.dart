part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSuccessfullyLogged extends AuthEvent {}

class AuthLogoutSubmitted extends AuthEvent {}

class AuthLoginForwarded extends AuthEvent {
  final String route;
  const AuthLoginForwarded(
    this.route,
  );
  @override
  List<Object?> get props => [route];
}

class AuthEmailChanged extends AuthEvent {
  final String? email;
  const AuthEmailChanged(
    this.email,
  );
  @override
  List<Object?> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String? password;
  const AuthPasswordChanged(
    this.password,
  );
  @override
  List<Object?> get props => [password];
}

class AuthSubmitted extends AuthEvent {}

class AuthRegistrationPageWent extends AuthEvent {}
