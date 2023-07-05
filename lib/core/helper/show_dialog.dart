import 'package:flutter/material.dart';

import '../widgets/custom_alert_dialog.dart';

class CustomDialog {
  static Future<dynamic> error(BuildContext context, String? errorMessage) {
    return showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        content: Column(
          children: [
            const Expanded(
              child: Center(
                child: Icon(
                  Icons.cancel_rounded,
                  color: Colors.grey,
                  size: 70,
                ),
              ),
            ),
            Expanded(
              child: Text(
                errorMessage ?? 'Une erreur s\'est produite',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<dynamic> success(BuildContext context, String? successMessage) {
    return showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        content: Column(
          children: [
            const Expanded(
              child: Center(
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 70,
                ),
              ),
            ),
            Expanded(
              child: Text(
                successMessage ?? 'Succès !',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
