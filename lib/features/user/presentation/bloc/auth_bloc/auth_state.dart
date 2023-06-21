part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.route = RouteName.splash,
    this.authStatus = Status.init,
    this.email,
    this.password,
    this.loginStatus = Status.init,
    this.loginBtnController,
    this.passwordError,
    this.failure,
    this.goto = GoTo.init,
  });

  final String? route;
  final Status? authStatus;
  final String? email;
  final String? password;
  final Status? loginStatus;
  final RoundedLoadingButtonController? loginBtnController;
  final String? passwordError;
  final Failure? failure;
  final GoTo? goto;

  @override
  List<Object?> get props => [
        route,
        authStatus,
        email,
        password,
        loginStatus,
        loginBtnController,
        passwordError,
        failure,
        goto,
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
    GoTo? goto,
  }) {
    return AuthState(
      route: route ?? this.route,
      authStatus: authStatus ?? this.authStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
      loginBtnController: loginBtnController ?? this.loginBtnController,
      passwordError:
          clearPasswordError ? null : passwordError ?? this.passwordError,
      failure: failure ?? this.failure,
      goto: goto ?? this.goto,
    );
  }
}
