import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_error_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/core/widgets/custom_text_field.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:gpt/core/models/required_input.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/icon_text_row_recognizer.dart';
import '../../../chat/presentation/bloc/chat_bloc.dart';
import '../bloc/registration_bloc/registration_bloc.dart';
import 'base_page.dart';

class NameAndPictureInputPage extends StatelessWidget {
  const NameAndPictureInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegistrationBloc, RegistrationState>(
          listenWhen: (previous, current) =>
              previous.updateStatus != current.updateStatus,
          listener: (context, state) {
            switch (state.updateStatus) {
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
        BlocListener<RegistrationBloc, RegistrationState>(
          listenWhen: (previous, current) =>
              previous.pickPictureStatus != current.pickPictureStatus,
          listener: (context, state) {
            if (state.pickPictureStatus == Status.failed) {
              showErrorDialog(context, state.failure?.message);
            }
          },
        ),
      ],
      child: BasePage(
        titleLarge: 'Vous y êtes presque !\nConfigurer votre profil',
        title:
            'Veuillez entrer votre nom et prénom et un photo de profil (optionnel) pour finaliser la création de votre compte',
        onPop: () => context.pop(),
        bodyLarge: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconTextRowRecognizer(
                            label: 'Camera',
                            icon: Icon(
                              Icons.camera,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              context.read<RegistrationBloc>().add(
                                    RegistrationPicturePicked(
                                      source: ImageSource.camera,
                                    ),
                                  );
                              context.pop();
                            },
                          ),
                          IconTextRowRecognizer(
                            label: 'Files',
                            icon: Icon(
                              Icons.folder,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              context.read<RegistrationBloc>().add(
                                    RegistrationPicturePicked(
                                      source: ImageSource.gallery,
                                    ),
                                  );
                              context.pop();
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    BlocBuilder<RegistrationBloc, RegistrationState>(
                      buildWhen: (previous, current) =>
                          previous.image != current.image,
                      builder: (context, state) {
                        final image = state.image;
                        if (image == null) {
                          return const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/placeholder.jpg'),
                            radius: 70,
                          );
                        }
                        return CircleAvatar(
                          backgroundImage: FileImage(File(image.path)),
                          radius: 70,
                        );
                      },
                    ),
                    const Positioned(
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
              ),
              BlocBuilder<RegistrationBloc, RegistrationState>(
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return CustomTextField(
                    label: '',
                    onFieldSubmitted: (_) => onSumbit(context),
                    decoration: InputDecoration(
                      hintText: 'nom et prénom',
                      errorText: state.name.isNotValid
                          ? state.name.displayError?.text
                          : null,
                    ),
                    onChanged: (value) => context
                        .read<RegistrationBloc>()
                        .add(RegistrationNameChanged(value)),
                  );
                },
              ),
              const Spacer(),
              BlocBuilder<RegistrationBloc, RegistrationState>(
                buildWhen: (previous, current) =>
                    previous.updateUserBtnController !=
                    current.updateUserBtnController,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CustomButtonWidget(ButtonType.black).build(
                      context: context,
                      controller: state.updateUserBtnController,
                      onPressed: () => onSumbit(context),
                      label: 'Terminer',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SizedBox.shrink(),
      ),
    );
  }
}

void onSumbit(BuildContext context) {
  unfocusKeyboard();
  context.read<RegistrationBloc>().add(RegistrationUserUpdated());
}
