import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/features/user/domain/usecases/check_auth_usecase.dart';
import 'package:gpt/features/user/domain/usecases/usecases.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/routes/route_name.dart';
import '../../../../../core/usecase/usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthUsecase checkAuth;
  final DeleteAuthUsecase deleteAuth;
  AuthBloc({
    required this.checkAuth,
    required this.deleteAuth,
  }) : super(const AuthState()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthSuccessfullyLogged>(_onAuthSuccessfullyLogged);
    on<AuthLogoutSubmitted>(_onAuthLogoutSubmitted);
    on<AuthLoginForwarded>(_onAuthLoginForwarded);
  }

  void _onAuthLoginForwarded(
    AuthLoginForwarded event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 5));
    emit(state.copyWith(route: RouteName.login));
  }

  void _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(authStatus: Status.loading));
    final res = await checkAuth(NoParams());
    return res.fold(
      (l) => null,
      (r) {
        if (r == null) {
          add(AuthLoginForwarded());
        } else {
          emit(state.copyWith(authStatus: Status.loaded));
          // emit(state.copyWith(route: RouteName.logged));
        }
      },
    );
  }

  void _onAuthSuccessfullyLogged(
    AuthSuccessfullyLogged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(route: RouteName.logged));
  }

  void _onAuthLogoutSubmitted(
    AuthLogoutSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final res = await deleteAuth(NoParams());
    res.fold((l) => null, (r) => emit(state.copyWith(route: RouteName.login)));
  }
}
