import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/scaffold_with_background.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.pop();
      },
      title: 'Foire Aux Questions',
      body: Container(),
    );
  }
}
