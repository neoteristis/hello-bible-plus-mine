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
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool? obscureText;
  final ValueSetter<String>? onChanged;
  final ValueSetter<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    final isLight =
        Theme.of(context).colorScheme.brightness == Brightness.light;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isLight
                    ? Theme.of(context).colorScheme.onSurface.withOpacity(.6)
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
        ),
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
          autofocus: true,
          keyboardType: keyboardType,
          onChanged: onChanged,
          onTapOutside: (event) => unfocusKeyboard(),
          onFieldSubmitted: onFieldSubmitted,
          style: TextStyle(color: Color(0xFF000000)),

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
