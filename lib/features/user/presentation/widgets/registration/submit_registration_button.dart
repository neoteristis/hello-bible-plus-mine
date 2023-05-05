import 'package:flutter/material.dart';

import '../../../../../core/widgets/rounded_loading_button.dart';

class SubmitRegistrationButton extends StatelessWidget {
  const SubmitRegistrationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: RoundedLoadingButtonController(),
      onPressed: () {},
      child: const Text('Valider'),
    );
  }
}
