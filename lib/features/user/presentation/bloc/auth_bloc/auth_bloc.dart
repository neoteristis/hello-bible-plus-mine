import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/features/user/domain/entities/user.dart';
import 'package:gpt/features/user/domain/usecases/usecases.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../core/widgets/rounded_loading_button.dart';
import '../../../../../l10n/function.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthUsecase checkAuth;
  final DeleteAuthUsecase deleteAuth;
  final LoginUsecase login;

  AuthBloc({
    required this.checkAuth,
    required this.deleteAuth,
    required this.login,
  }) : super(AuthState(loginBtnController: RoundedLoadingButtonController())) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthSuccessfullyLogged>(_onAuthSuccessfullyLogged);
    on<AuthLogoutSubmitted>(_onAuthLogoutSubmitted);
    on<AuthLoginForwarded>(_onAuthLoginForwarded);
    on<AuthEmailChanged>(_onAuthEmailChanged);
    on<AuthPasswordChanged>(_onAuthPasswordChanged);
    on<AuthSubmitted>(_onAuthSubmitted);
    on<AuthRegistrationPageWent>(_onAuthRegistrationPageWent);
  }

  void _onAuthRegistrationPageWent(
    AuthRegistrationPageWent event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 10));
  }

  void _onAuthSubmitted(
    AuthSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final password = state.password;
    if (password == null) {
      return emit(
        state.copyWith(
          passwordError: dict(event.context).thisFieldIsRequired,
        ),
      );
    }
    emit(
      state.copyWith(
        clearPasswordError: true,
        loginStatus: Status.loading,
      ),
    );
    state.loginBtnController?.start();
    final res = await login(
      User(
        email: state.email,
        password: state.password,
      ),
    );
    state.loginBtnController?.stop();
    return res.fold(
      (l) => emit(
        state.copyWith(
          loginStatus: Status.failed,
          failure: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          loginStatus: Status.loaded,
        ),
      ),
    );
  }

  void _onAuthPasswordChanged(
    AuthPasswordChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  void _onAuthEmailChanged(
    AuthEmailChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  void _onAuthLoginForwarded(
    AuthLoginForwarded event,
    Emitter<AuthState> emit,
  ) async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    emit(state.copyWith(
      route: event.route,
    ));
  }

  void _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(
      authStatus: Status.loading,
    ));
    final res = await checkAuth(NoParams());
    return res.fold(
      (l) => emit(state.copyWith(
        authenticationStatus: AuthStatus.unknown,
      )),
      (r) {
        if (r == null) {
          emit(state.copyWith(
            authenticationStatus: AuthStatus.unauthenticated,
          ));
        } else {
          emit(state.copyWith(
            authStatus: Status.loaded,
            isLogged: true,
            authenticationStatus: AuthStatus.authenticated,
          ));
        }
      },
    );
  }

  void _onAuthSuccessfullyLogged(
    AuthSuccessfullyLogged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(authenticationStatus: AuthStatus.authenticated));
  }

  void _onAuthLogoutSubmitted(
    AuthLogoutSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final res = await deleteAuth(NoParams());
    res.fold(
      (l) => null,
      (r) {
        emit(
          state.copyWith(authenticationStatus: AuthStatus.unauthenticated),
        );

        ///add(AuthRegistrationPageWent());
      },
    );
  }
}
