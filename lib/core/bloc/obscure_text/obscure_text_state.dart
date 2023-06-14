part of 'obscure_text_cubit.dart';

class ObscureTextState extends Equatable {
  const ObscureTextState({
    required this.isObscurePsd,
    required this.isObscureConfirm,
  });

  ObscureTextState copyWith({bool? isObscurePsd, bool? isObscureConfirm}) {
    return ObscureTextState(
        isObscurePsd: isObscurePsd ?? this.isObscurePsd,
        isObscureConfirm: isObscureConfirm ?? this.isObscureConfirm);
  }

  final bool isObscurePsd;
  final bool isObscureConfirm;

  @override
  List<Object> get props => [isObscurePsd, isObscureConfirm];
}
