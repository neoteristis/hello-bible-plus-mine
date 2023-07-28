import 'package:flutter/material.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.controller,
    this.decoration,
    this.obscureText,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.enabled = true,
    this.autofocus = true,
  });

  final String? label;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool? obscureText;
  final ValueSetter<String>? onChanged;
  final ValueSetter<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final bool? enabled;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(

                ),
          ),
        if (label != null)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          cursorColor: Colors.black,
          focusNode: focusNode,
          obscureText: obscureText ?? false,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          decoration: decoration,
          autofocus: autofocus ?? true,
          keyboardType: keyboardType,
          onChanged: onChanged,
          onTapOutside: (event) => unfocusKeyboard(),
          onFieldSubmitted: onFieldSubmitted,
          style: const TextStyle(color: Color(0xFF000000)),
          maxLines: maxLines,
          enabled: enabled,

          // style: TextStyle(
          //   fontWeight: FontWeight.w500,
          //   fontSize: 14,
          //   color: Color(0xFF223159).withOpacity(.9),
          // ),
        ),
      ],
    );
  }
}
