import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

ThemeData theme(Color? color) => ThemeData(
      fontFamily: 'Poppins',
      primaryColor: color ?? ColorConstants.primary,
      scaffoldBackgroundColor: ColorConstants.background,
      useMaterial3: true,
    );
