part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.route = RouteName.login,
  });

  final String? route;

  @override
  List<Object?> get props => [route];

  AuthState copyWith({
    String? route,
  }) {
    return AuthState(
      route: route ?? this.route,
    );
  }
}
