import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_error_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/routes/route_name.dart';
import 'custom_password_input.dart';
import 'input_base_page.dart';

class PasswordInputPage extends StatelessWidget {
  const PasswordInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.loginStatus != current.loginStatus,
          listener: (context, state) {
            switch (state.loginStatus) {
              case Status.loaded:
                context
                  ..read<AuthBloc>().add(AuthSuccessfullyLogged())
                  ..read<ChatBloc>().add(
                    ChatCategoriesBySectionFetched(),
                  );
                break;
              case Status.failed:
                showErrorDialog(context, state.failure?.message);
                break;
              default:
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.goto != current.goto,
          listener: (context, state) {
            // go to the first page after logout
            if (state.goto == GoTo.registration) {
              context.go(RouteName.registration);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) =>
            previous.loginBtnController != current.loginBtnController,
        builder: (context, state) {
          return InputBasePage(
            title: 'Continuer pour se connecter à votre compte',
            field: BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) =>
                  previous.passwordError != current.passwordError,
              builder: (context, state) {
                return CustomPasswordInput(
                  label: 'Saisir mon mot de passe',
                  onChanged: (password) => context
                      .read<AuthBloc>()
                      .add(AuthPasswordChanged(password)),
                  errorText: state.passwordError,
                  onFieldSubmitted: (_) => onSubmit(
                    context,
                  ),
                );
              },
            ),
            buttonController: state.loginBtnController,
            onContinue: () => onSubmit(
              context,
            ),
          );
        },
      ),
    );
  }
}

void onSubmit(BuildContext context) {
  unfocusKeyboard();
  context.read<AuthBloc>().add(AuthSubmitted());
}
