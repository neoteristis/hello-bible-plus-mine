import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/core/models/required_input.dart';
import 'package:gpt/features/introduction/presentation/pages/landing_page.dart';
import 'package:gpt/features/user/presentation/pages/email_input_page.dart';
import 'package:gpt/features/user/presentation/pages/name_and_picture_input_page.dart';
import 'package:gpt/features/user/presentation/pages/registration_page.dart';
import '../../../../core/constants/status.dart';
import '../../../../l10n/function.dart';
import '../bloc/registration_bloc/registration_bloc.dart';
import 'custom_password_input.dart';
import 'input_base_page.dart';

class CreatePasswordInputPage extends StatefulWidget {
  static const String route = 'create-new-password';

  const CreatePasswordInputPage({super.key});

  @override
  State<CreatePasswordInputPage> createState() =>
      _CreatePasswordInputPageState();
}

class _CreatePasswordInputPageState extends State<CreatePasswordInputPage> {
  late final FocusNode confirmPsdFocusNode;

  @override
  void initState() {
    super.initState();

    confirmPsdFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case Status.loaded:
            context.go('/${LandingPage.route}/${RegistrationPage.route}/${EmailInputPage.route}/${NameAndPictureInputPage.route}');
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
                      FocusScope.of(context).requestFocus(confirmPsdFocusNode);
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
                    focusNode: confirmPsdFocusNode,
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
