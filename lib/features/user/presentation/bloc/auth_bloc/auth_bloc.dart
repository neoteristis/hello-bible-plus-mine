import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/features/user/domain/usecases/check_auth_usecase.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/usecase/usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthUsecase checkAuth;
  AuthBloc({
    required this.checkAuth,
  }) : super(const AuthState()) {
    on<AuthStarted>(_onAuthStarted);
  }

  void _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    final res = await checkAuth(NoParams());
    res.fold((l) => null, (r) {
      if (r == null) {
        emit(state.copyWith(route: RouteName.login));
      } else {
        emit(state.copyWith(route: RouteName.logged));
      }
    });
  }
}
