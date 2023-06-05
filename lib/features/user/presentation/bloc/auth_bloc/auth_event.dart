part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSuccessfullyLogged extends AuthEvent {}

class AuthLogoutSubmitted extends AuthEvent {}

class AuthLoginForwarded extends AuthEvent {}
