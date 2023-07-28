part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState extends Equatable {
  const AuthState({
    this.authStatus = Status.init,
    this.email,
    this.password,
    this.loginStatus = Status.init,
    this.loginBtnController,
    this.passwordError,
    this.failure,
    this.isLogged = false,
    this.authenticationStatus = AuthStatus.unknown,
  });

  final AuthStatus authenticationStatus;
  final Status? authStatus;
  final String? email;
  final String? password;
  final Status? loginStatus;
  final RoundedLoadingButtonController? loginBtnController;
  final String? passwordError;
  final Failure? failure;
  final bool isLogged;

  @override
  List<Object?> get props => [
        authStatus,
        email,
        password,
        loginStatus,
        loginBtnController,
        passwordError,
        failure,
        isLogged,
        authenticationStatus,
      ];

  AuthState copyWith({
    String? route,
    Status? authStatus,
    String? email,
    String? password,
    Status? loginStatus,
    RoundedLoadingButtonController? loginBtnController,
    String? passwordError,
    bool clearPasswordError = false,
    Failure? failure,
    bool? isLogged,
    AuthStatus? authenticationStatus,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
      loginBtnController: loginBtnController ?? this.loginBtnController,
      passwordError:
          clearPasswordError ? null : passwordError ?? this.passwordError,
      failure: failure ?? this.failure,
      isLogged: isLogged ?? this.isLogged,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }
}
