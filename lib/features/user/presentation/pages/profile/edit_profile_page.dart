import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_button_widget.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';
import 'package:intl/intl.dart';
import '../../../../../core/helper/show_dialog.dart';
import '../../../../../core/models/required_input.dart';
import '../../../../../l10n/function.dart';
import '../../../data/models/email_input.dart';
import '../../../data/models/number_input.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/scaffold_with_background.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../widgets/profile/profiles.dart';

class EditProfilePage extends StatelessWidget {
  static const String route = 'edit-profile';
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) =>
              previous.updateStatus != current.updateStatus,
          listener: (context, state) {
            switch (state.updateStatus) {
              case Status.loaded:
                CustomDialog.success(
                  context,
                  dict(context).successfulUpdate,
                );
                break;
              case Status.failed:
                CustomDialog.error(
                  context,
                  state.failure?.message,
                );
                break;
              default:
            }
          },
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (previous, current) =>
              previous.updatePictureStatus != current.updatePictureStatus,
          listener: (context, state) {
            switch (state.updatePictureStatus) {
              case Status.loaded:
                CustomDialog.success(
                  context,
                  dict(context).successfulUpdate,
                );
                break;
              case Status.failed:
                CustomDialog.error(
                  context,
                  state.failure?.message,
                );
                break;
              default:
            }
          },
        ),
      ],
      child: ScaffoldWithBackground(
        addBackgroundImage: false,
        persistentFooterButtons: [
          BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) =>
                previous.buttonController != current.buttonController,
            builder: (context, state) {
              return CustomButtonWidget(ButtonType.black).build(
                controller: state.buttonController,
                context: context,
                onPressed: () {
                  context.read<ProfileBloc>().add(ProfileUpdated());
                },
                label: dict(context).updateMyProfile,
              );
            },
          )
        ],
        onPop: () {
          context.pop();
        },
        title: dict(context).modifyMyAccount,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.loaded:
                return BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) =>
                      previous.user != current.user,
                  builder: (context, state) {
                    final user = state.user;
                    final createdAt = user?.createdAt;
                    if (user == null) {
                      return const Center(
                        child: Text(
                          'Profile introuvable',
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const UserProfilePictureWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          const ProfileNameInput(),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dict(context).generalInformations,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              UserInformationWidget(
                                label: dict(context).email,
                              ),
                              const ProfileEmailInput(),
                              UserInformationWidget(
                                label: dict(context).phone,
                              ),
                              const ProfilePhoneInput(),
                              if (createdAt != null)
                                UserInformationWidget(
                                  label: dict(context).creationDate,
                                  value: DateFormat('dd/MM/yyyy')
                                      .format(createdAt.toLocal()),
                                ),
                              if (createdAt == null)
                                UserInformationWidget(
                                  label: dict(context).creationDate,
                                  value: '02/12/2023',
                                ),
                            ],
                          ),
                          const CustomDivider(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                          ),
                          const UserSubscriptionPlansWidget(),
                        ],
                      ),
                    );
                  },
                );
              case Status.failed:
                return const Center(
                  child: Text(
                    'Une erreur s\'est produite',
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class ProfileNameInput extends StatelessWidget {
  const ProfileNameInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.inputs.name != current.inputs.name,
      builder: (context, state) {
        final name = state.inputs.name;
        return CustomTextField(
          controller: state.nameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF3F5F7),
              suffixIcon: IconButton(
                onPressed: () {
                  state.nameController?.clear();
                  context.read<ProfileBloc>().add(
                        const ProfileNameChanged(''),
                      );
                },
                icon: const Icon(Icons.cancel),
              ),
              errorText:
                  name.isNotValid ? name.displayError?.text(context) : null),
          onChanged: (value) => context.read<ProfileBloc>().add(
                ProfileNameChanged(value),
              ),
        );
      },
    );
  }
}

class ProfileEmailInput extends StatelessWidget {
  const ProfileEmailInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.inputs.email != current.inputs.email,
      builder: (context, state) {
        final email = state.inputs.email;
        return CustomTextField(
          controller: state.emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F5F7),
            suffixIcon: IconButton(
              onPressed: () {
                state.emailController?.clear();
                context.read<ProfileBloc>().add(const ProfileEmailChanged(''));
              },
              icon: const Icon(Icons.cancel),
            ),
            errorText:
                email.isNotValid ? email.displayError?.text(context) : null,
          ),
          onChanged: (value) {
            context.read<ProfileBloc>().add(ProfileEmailChanged(value));
          },
        );
      },
    );
  }
}

class ProfilePhoneInput extends StatelessWidget {
  const ProfilePhoneInput({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.inputs.phone != current.inputs.phone,
      builder: (context, state) {
        final phone = state.inputs.phone;
        return CustomTextField(
          controller: state.phoneController,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F5F7),
            suffixIcon: IconButton(
              onPressed: () {
                state.phoneController?.clear();
                context.read<ProfileBloc>().add(const ProfilePhoneChanged(''));
              },
              icon: const Icon(Icons.cancel),
            ),
            errorText:
                phone.isNotValid ? phone.displayError?.text(context) : null,
          ),
          onChanged: (value) {
            context.read<ProfileBloc>().add(ProfilePhoneChanged(value));
          },
        );
      },
    );
  }
}
