part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.route = RouteName.splash,
    this.authStatus = Status.init,
  });

  final String? route;
  final Status? authStatus;

  @override
  List<Object?> get props => [
        route,
        authStatus,
      ];

  AuthState copyWith({
    String? route,
    Status? authStatus,
  }) {
    return AuthState(
      route: route ?? this.route,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
