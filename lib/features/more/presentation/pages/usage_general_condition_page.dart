import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/l10n/function.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../container/pages/section/presentation/pages/section_page.dart';

class UsageGeneralConditionPage extends StatelessWidget {
  static const String route = 'usage-general-condition';
  const UsageGeneralConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.go('/${SectionPage.route}');
      },
      title: dict(context).termsOfService,
      body: Container(),
    );
  }
}
