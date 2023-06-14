import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/bloc/obscure_text/obscure_text_cubit.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'custom_password_input.dart';
import 'input_base_page.dart';

class PasswordInputPage extends StatelessWidget {
  const PasswordInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return InputBasePage(
      title: 'Continuer pour se connecter à votre compte',
      field: CustomPasswordInput(
        label: 'Saisir mon mot de passe',
      ),
      onContinue: () {
        context.go(RouteName.newPassword);
      },
    );
  }
}
