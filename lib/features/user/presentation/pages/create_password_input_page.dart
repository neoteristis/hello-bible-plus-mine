import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/core/models/required_input.dart';
import '../../../../core/constants/status.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../l10n/function.dart';
import '../bloc/registration_bloc/registration_bloc.dart';
import 'custom_password_input.dart';
import 'input_base_page.dart';

class CreatePasswordInputPage extends StatelessWidget {

  static const String route = 'create-new-password';

  const CreatePasswordInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode _confirmPsdFocusNode = FocusNode();
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case Status.loaded:
            context.go(RouteName.namePicture);
            break;
          case Status.failed:
            CustomDialog.error(context, state.failure?.message);
            break;
          default:
        }
      },
      buildWhen: (previous, current) =>
          previous.registrationBtnController !=
          current.registrationBtnController,
      builder: (context, state) {
        return InputBasePage(
          title: dict(context).continueForCreateYourAccount,
          field: Column(
            children: [
              BlocBuilder<RegistrationBloc, RegistrationState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return CustomPasswordInput(
                    label: dict(context).createMyPassword,
                    onChanged: (value) => context.read<RegistrationBloc>().add(
                          RegistrationPasswordChanged(value),
                        ),
                    errorText: state.password.isNotValid
                        ? state.password.displayError?.text(context)
                        : null,
                    onFieldSubmitted: (_) {
                      unfocusKeyboard();
                      FocusScope.of(context).requestFocus(_confirmPsdFocusNode);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 13,
              ),
              BlocBuilder<RegistrationBloc, RegistrationState>(
                buildWhen: (previous, current) =>
                    previous.confirmPassword != current.confirmPassword ||
                    previous.confirmPassordError != current.confirmPassordError,
                builder: (context, state) {
                  return CustomPasswordInput(
                    focusNode: _confirmPsdFocusNode,
                    label: dict(context).confirmTheNewPassword,
                    onChanged: (value) => context.read<RegistrationBloc>().add(
                          RegistrationConfirmPasswordChanged(value),
                        ),
                    errorText: state.confirmPassordError,
                    onFieldSubmitted: (_) => onSubmit(context),
                  );
                },
              ),
            ],
          ),
          buttonController: state.registrationBtnController,
          onContinue: () => onSubmit(context),
        );
      },
    );
  }
}

void onSubmit(BuildContext context) {
  unfocusKeyboard();
  context.read<RegistrationBloc>().add(RegistrationSubmitted(context));
}
