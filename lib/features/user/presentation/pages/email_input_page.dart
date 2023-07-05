import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';

import 'package:gpt/features/user/data/models/email_input.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../l10n/function.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/registration_bloc/registration_bloc.dart';
import 'input_base_page.dart';

class EmailInputPage extends StatelessWidget {
  const EmailInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegistrationBloc, RegistrationState>(
          listenWhen: (previous, current) => previous.goto != current.goto,
          listener: (context, state) {
            switch (state.goto) {
              case GoTo.login:
                return context.go(RouteName.password);
              case GoTo.registration:
                return context.go(RouteName.newPassword);
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
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return CustomTextField(
                    onChanged: (value) {
                      context
                        ..read<RegistrationBloc>().add(
                          RegistrationEmailChanged(value),
                        )
                        ..read<AuthBloc>().add(
                          AuthEmailChanged(value),
                        );
                    },
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (_) => onSubmit(context),
                    label: dict(context).enterMyEmail,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F5F7),
                      hintText: dict(context).hintEmailInput,
                      errorMaxLines: 2,
                      hintStyle: const TextStyle(color: Color(0xFF223159)),
                      errorText: state.email.isNotValid
                          ? state.email.displayError?.text(context)
                          : null,
                    ),
                  );
                },
              ),
              buttonController: state.checkEmailBtnController,
              onContinue: () => onSubmit(context));
        },
      ),
    );
  }
}

void onSubmit(BuildContext context) {
  unfocusKeyboard();
  context.read<RegistrationBloc>().add(const RegistrationEmailChecked());
}
