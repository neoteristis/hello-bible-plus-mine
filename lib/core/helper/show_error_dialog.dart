import 'package:flutter/material.dart';

import '../widgets/custom_alert_dialog.dart';

Future<dynamic> showErrorDialog(BuildContext context, String? errorMessage) {
  return showDialog(
    context: context,
    builder: (context) => CustomAlertDialog(
      content: Center(
        child: Text(
          errorMessage ?? 'Une erreur s\'est produite',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
