import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_error_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';

import 'package:gpt/features/user/data/models/email_input.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/widgets/custom_text_field.dart';
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
              showErrorDialog(context, state.failure?.message);
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
                    onFieldSubmitted: (_) => onSubmit(context),
                    label: 'Renseigner mon email',
                    decoration: InputDecoration(
                      hintText: 'exemple@mondomaine.fr',
                      errorMaxLines: 2,
                      errorText: state.email.isNotValid
                          ? state.email.displayError?.text
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
