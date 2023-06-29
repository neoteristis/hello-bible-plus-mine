import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/scaffold_with_background.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.pop();
      },
      title: 'A propos',
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText('HelloBible+'),
            CustomText('Version : 1.0'),
            CustomText(
              'HelloBible+ est une application mobile pour lorem ipsum dolor sit amet consectetur. Adipiscing proin in porttitor morbi mattis tellus. Posuere egestas sem gravida hendrerit turpis aliquam. Convallis velit dapibus dictum lacinia.',
            ),
            TextValue(
              label: 'Développeur',
              value: 'Développeur Madagascar',
            ),
            TextValue(
              label: 'Contact',
              value: 'E-mail : hellobible@hellobible.mg',
            ),
            TextValue(
              label: 'Siteweb',
              value: 'https://www.hellobible.com',
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
