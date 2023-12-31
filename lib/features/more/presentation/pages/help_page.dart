import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../../l10n/function.dart';

class HelpPage extends StatelessWidget {
  static const String route = 'help';
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.pop();
      },
      title: dict(context).frequentlyAskedQuestions,
      body: Container(),
    );
  }
}
