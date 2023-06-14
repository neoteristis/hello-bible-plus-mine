import 'package:flutter/material.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.decoration,
    this.obscureText,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
  });

  final String label;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool? obscureText;
  final ValueSetter<String>? onChanged;
  final ValueSetter<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: const Color(0xFF223159).withOpacity(.6),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          controller: controller,
          decoration: decoration,
          autofocus: true,
          onChanged: onChanged,
          onTapOutside: (event) => unfocusKeyboard(),
          onFieldSubmitted: onFieldSubmitted,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xFF223159).withOpacity(.9),
          ),
        ),
      ],
    );
  }
}
