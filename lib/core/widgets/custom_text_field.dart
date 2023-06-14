import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.controller,
    this.decoration,
    this.obscureText,
  });

  final String label;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final bool? obscureText;

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
        SizedBox(
          height: 50,
          child: TextFormField(
            obscureText: obscureText ?? false,
            controller: controller,
            decoration: decoration,
            autofocus: true,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF223159).withOpacity(.9),
            ),
          ),
        ),
      ],
    );
  }
}
