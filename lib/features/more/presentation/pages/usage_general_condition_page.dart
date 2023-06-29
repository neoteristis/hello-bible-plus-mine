import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/scaffold_with_background.dart';

class UsageGeneralConditionPage extends StatelessWidget {
  const UsageGeneralConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.pop();
      },
      title: 'Conditions Générales d\'Utilisation',
      body: Container(),
    );
  }
}
