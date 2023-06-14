import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_name.dart';
import 'custom_password_input.dart';
import 'input_base_page.dart';

class CreatePasswordInputPage extends StatelessWidget {
  const CreatePasswordInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InputBasePage(
      title: 'Continuer pour créer votre compte',
      field: const Column(
        children: [
          CustomPasswordInput(
            label: 'Créer mon mot de passe',
          ),
          SizedBox(
            height: 13,
          ),
          CustomPasswordInput(
            label: 'Confirmer le nouveau mot de passe',
          ),
        ],
      ),
      onContinue: () {
        context.go(RouteName.namePicture);
      },
    );
  }
}
