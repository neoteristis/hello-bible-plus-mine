import 'package:flutter/material.dart';

part 'dark_theme.dart';

part 'light_theme.dart';

const primaryColor = Color(0xFF22B573);

const titleLarge = TextStyle(
  fontSize: 25.5,
);

const titleMedium = TextStyle(
  color: Colors.black, // <-- TextFormField input color
);

final bodyLarge = TextStyle(
  color: const Color(0xFF223159).withOpacity(.6),
  fontSize: 16,
);
const headlineLarge = TextStyle(
  fontWeight: FontWeight.w800,
  fontSize: 20,
  color: Color(0xFF101520),
);
const headlineMedium = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 31,
  color: Color(
    0xFF0C0C0C,
  ),
);
const labelLarge = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 14,
  color: Color(
    0xFF223159,
  ),
);

const labelMedium = TextStyle(
  fontSize: 12,
  color: Color(0xFF646F8B),
);

const titleSmall = TextStyle(
  fontWeight: FontWeight.w600,
);

const labelSmall = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 11,
);

bool isLight(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark;
