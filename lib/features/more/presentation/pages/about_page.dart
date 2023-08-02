import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/l10n/function.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../container/pages/section/presentation/pages/section_page.dart';

class AboutPage extends StatelessWidget {
  static const String route = 'about';
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.go('/${SectionPage.route}');
      },
      title: dict(context).about,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText('HelloBible+'),
            CustomText('${dict(context).version} : 1.0'),
            CustomText(
              dict(context).appliDescription,
            ),
            TextValue(
              label: dict(context).developer,
              value: 'MyAgency team',
            ),
            TextValue(
              label: dict(context).contact,
              value: 'E-mail : contact@myagency.mg',
            ),
            TextValue(
              label: dict(context).website,
              value: 'https://www.hellobible.app/',
            ),
          ],
        ),
      ),
    );
  }
}

class TextValue extends StatelessWidget {
  const TextValue({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            '$label :',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        CustomText(value),
      ],
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
