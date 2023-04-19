import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? CircularProgressIndicator(
            color: ColorConstants.primary,
          )
        : CupertinoActivityIndicator(
            color: ColorConstants.primary,
          );
  }
}
