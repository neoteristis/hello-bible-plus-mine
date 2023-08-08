import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/features/introduction/presentation/pages/landing_page.dart';

import 'package:gpt/features/user/data/models/email_input.dart';
import 'package:gpt/features/user/presentation/pages/create_password_input_page.dart';
import 'package:gpt/features/user/presentation/pages/passwod_input_page.dart';
import 'package:gpt/features/user/presentation/pages/registration_page.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../l10n/function.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/registration_bloc/registration_bloc.dart';
import 'input_base_page.dart';

class EmailInputPage extends StatelessWidget {
  static const String route = 'email-input';

  EmailInputPage({super.key});

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegistrationBloc, RegistrationState>(
          listenWhen: (previous, current) =>
              previous.nextStep != current.nextStep,
          listener: (context, state) {
            switch (state.nextStep) {
              case Goto.login:
                return context.go(
                    '/${LandingPage.route}/${RegistrationPage.route}/${EmailInputPage.route}/${PasswordInputPage.route}');
              case Goto.registration:
                return context.go(
                    '/${LandingPage.route}/${RegistrationPage.route}/${EmailInputPage.route}/${CreatePasswordInputPage.route}');
              default:
            }
          },
        ),
        BlocListener<RegistrationBloc, RegistrationState>(
          listenWhen: (previous, current) =>
              previous.emailCheckStatus != current.emailCheckStatus,
          listener: (context, state) {
            if (state.emailCheckStatus == Status.failed) {
              CustomDialog.error(context, state.failure?.message);
            }
          },
        ),
      ],
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) =>
            previous.checkEmailBtnController != current.checkEmailBtnController,
        builder: (context, state) {
          return InputBasePage(
            field: BlocBuilder<RegistrationBloc, RegistrationState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return CustomTextField(
                  controller: controller,
                  onChanged: (value) {
                    context
                        // ..read<RegistrationBloc>().add(
                        //   RegistrationEmailChanged(value),
                        // )
                        // .
                        .read<AuthBloc>()
                        .add(
                          AuthEmailChanged(value),
                        );
                  },
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (email) => onSubmit(
                    context: context,
                    email: email,
                  ),
                  label: dict(context).enterMyEmail,
                  decoration: InputDecoration(
                    // border: inputBorder(context),
                    // focusedBorder: inputBorder(context),
                    // enabledBorder: inputBorder(context),
                    filled: true,
                    fillColor: const Color(0xFFF3F5F7),
                    hintText: dict(context).hintEmailInput,
                    errorMaxLines: 2,
                    hintStyle: const TextStyle(
                      color: Color(0xFF223159),
                    ),
                    errorText: state.email.isNotValid
                        ? state.email.displayError?.text(context)
                        : null,
                  ),
                );
              },
            ),
            buttonController: state.checkEmailBtnController,
            onContinue: () =>
                onSubmit(context: context, email: controller.text),
          );
        },
      ),
    );
  }
}

InputBorder inputBorder(BuildContext context) => OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
    );

void onSubmit({
  required BuildContext context,
  required String email,
}) {
  unfocusKeyboard();
  context.read<RegistrationBloc>().add(RegistrationEmailChecked(email));
}
