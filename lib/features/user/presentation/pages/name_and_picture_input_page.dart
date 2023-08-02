import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/show_dialog.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/core/widgets/custom_text_field.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:gpt/core/models/required_input.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/icon_text_row_recognizer.dart';
import '../../../../l10n/function.dart';
import '../../../container/pages/home/presentation/bloc/home_bloc.dart';
import '../bloc/registration_bloc/registration_bloc.dart';
import 'base_page.dart';

class NameAndPictureInputPage extends StatelessWidget {
  static const String route = 'named-and-picture-input-page';
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
                  ..read<HomeBloc>().add(
                    ChatCategoriesBySectionFetched(),
                  );
                break;
              case Status.failed:
                CustomDialog.error(context, state.failure?.message);
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
              CustomDialog.error(context, state.failure?.message);
            }
          },
        ),
      ],
      child: BasePage(
        titleLarge: dict(context).youAreAlmostThere,
        title: dict(context).pleaseEnterYourFirstAndLastName,
        onPop: () => context.pop(),
        bodyLarge: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            label: dict(context).camera,
                            icon: Icon(
                              Icons.camera,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              context.read<RegistrationBloc>().add(
                                    const RegistrationPicturePicked(
                                      source: ImageSource.camera,
                                    ),
                                  );
                              context.pop();
                            },
                          ),
                          IconTextRowRecognizer(
                            label: dict(context).files,
                            icon: Icon(
                              Icons.folder,
                              color: Theme.of(context).primaryColor,
                            ),
                            onTap: () {
                              context.read<RegistrationBloc>().add(
                                    const RegistrationPicturePicked(
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
                    textCapitalization: TextCapitalization.words,
                    onFieldSubmitted: (_) => onSumbit(context),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F5F7),
                      hintStyle: const TextStyle(color: Color(0xFF223159)),
                      hintText: dict(context).nameAndFirstname,
                      errorText: state.name.isNotValid
                          ? state.name.displayError?.text(context)
                          : null,
                    ),
                    onChanged: (value) => context
                        .read<RegistrationBloc>()
                        .add(RegistrationNameChanged(value)),
                  );
                },
              ),
              // const Spacer(),
              const SizedBox(
                height: 20,
              ),
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
                      label: dict(context).finish,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: const SizedBox.shrink(),
      ),
    );
  }
}

void onSumbit(BuildContext context) {
  unfocusKeyboard();
  context.read<RegistrationBloc>().add(RegistrationUserUpdated());
}
