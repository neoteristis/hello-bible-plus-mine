import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/obscure_text/obscure_text_cubit.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CustomPasswordInput extends StatelessWidget {
  const CustomPasswordInput({
    super.key,
    required this.label,
    this.onChanged,
    this.errorText,
    this.onFieldSubmitted,
    this.focusNode,
  });

  final String label;
  final ValueSetter<String>? onChanged;
  final String? errorText;
  final ValueSetter<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObscureTextCubit, ObscureTextState>(
      buildWhen: (previous, current) =>
          previous.isObscurePsd != current.isObscurePsd,
      builder: (context, state) {
        return CustomTextField(
          focusNode: focusNode,
          label: label,
          obscureText: state.isObscurePsd,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: '• • • • • • • • • • • • • • • •',
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF223159),
            ),
            errorText: errorText,
            suffixIcon: IconButton(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.center,
              onPressed: () {
                context.read<ObscureTextCubit>().switchObscurePassword();
              },
              icon: IconButton(
                icon: Visibility(
                  visible: state.isObscurePsd,
                  replacement: const Icon(Icons.visibility_off_outlined),
                  child: const Icon(
                    Icons.remove_red_eye_outlined,
                  ),
                ),
                onPressed: () =>
                    context.read<ObscureTextCubit>().switchObscurePassword(),
              ),
              iconSize: 20,
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
        );
      },
    );
  }
}
