import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_text_field.dart';

import '../../../../core/widgets/custom_button_widget.dart';
import 'base_page.dart';

class NameAndPictureInputPage extends StatelessWidget {
  const NameAndPictureInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      titleLarge: 'Vous y êtes presque !\nConfigurer votre profil',
      title:
          'Veuillez entrer votre nom et prénom et un photo de profil (optionnel) pour finaliser la création de votre compte',
      onPop: () => context.pop(),
      bodyLarge: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Stack(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/placeholder.jpg'),
                  radius: 70,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFF007AFF),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            CustomTextField(
              label: '',
              decoration: InputDecoration(hintText: 'nom et prénom'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: CustomButtonWidget(ButtonType.black).build(
                context: context,
                onPressed: () {},
                label: 'Terminer',
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox.shrink(),
    );
  }
}
