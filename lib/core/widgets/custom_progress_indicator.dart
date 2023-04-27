import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )
        : CupertinoActivityIndicator(
            color: Theme.of(context).primaryColor,
          );
  }
}
