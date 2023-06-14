import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'obscure_text_state.dart';

class ObscureTextCubit extends Cubit<ObscureTextState> {
  ObscureTextCubit()
      : super(
            const ObscureTextState(isObscurePsd: true, isObscureConfirm: true));

  void switchObscurePassword() =>
      emit(state.copyWith(isObscurePsd: !state.isObscurePsd));
  void switchObscureConfirm() =>
      emit(state.copyWith(isObscureConfirm: !state.isObscureConfirm));
  // void switchObscurePassword() => emit(ObscureTextState(isObscure: !(state.isObscure)),);
}
