import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/obscure_text/obscure_text_cubit.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'input_base_page.dart';

class CustomPasswordInput extends StatelessWidget {
  const CustomPasswordInput({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObscureTextCubit, ObscureTextState>(
      buildWhen: (previous, current) =>
          previous.isObscurePsd != current.isObscurePsd,
      builder: (context, state) {
        return CustomTextField(
          label: label,
          obscureText: state.isObscurePsd,
          decoration: InputDecoration(
            hintText: '• • • • • • • • • • • • • • • •',
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF223159),
            ),
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
        );
      },
    );
  }
}
