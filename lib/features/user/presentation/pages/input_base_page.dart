import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_button_widget.dart';

import 'base_page.dart';

class InputBasePage extends StatelessWidget {
  const InputBasePage({
    super.key,
    required this.field,
    required this.onContinue,
    this.title,
    this.goBackSocialConnect,
  });

  final Widget field;
  final VoidCallback onContinue;
  final String? title;
  final bool? goBackSocialConnect;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      onPop: () {
        context.pop();
      },
      goBackSocialConnect: goBackSocialConnect,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            field,
            SizedBox(
              height: 15,
            ),
            CustomButtonWidget(ButtonType.black).build(
                context: context,
                onPressed: onContinue,
                label: 'Continuer',
                width: double.infinity),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      title: title,
    );
  }
}
