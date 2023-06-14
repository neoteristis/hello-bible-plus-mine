import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_button_widget.dart';
import 'package:gpt/core/widgets/rounded_loading_button.dart';

import 'base_page.dart';

class InputBasePage extends StatelessWidget {
  const InputBasePage({
    super.key,
    required this.field,
    required this.onContinue,
    this.title,
    this.goBackSocialConnect,
    this.buttonController,
  });

  final Widget field;
  final VoidCallback onContinue;
  final String? title;
  final bool? goBackSocialConnect;
  final RoundedLoadingButtonController? buttonController;

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
              controller: buttonController,
              context: context,
              onPressed: onContinue,
              label: 'Continuer',
            ),
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
