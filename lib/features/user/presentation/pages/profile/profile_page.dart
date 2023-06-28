import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/routes/route_name.dart';
import 'package:gpt/core/widgets/custom_button_widget.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_widget.dart';
import 'package:gpt/features/user/domain/entities/user.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../core/widgets/scaffold_with_background.dart';
import '../../bloc/profile_bloc/profile_bloc.dart';
import '../../widgets/profile/profiles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileStarted());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      persistentFooterButtons: [
        CustomButtonWidget(ButtonType.black).build(
          context: context,
          onPressed: () {},
          color: const Color(0xFF24282E),
          label: 'Mettre à jour Abonnement',
          labelColor: const Color(0xFFEFBB56),
        ),
      ],
      onPop: () {
        context.pop();
      },
      title: 'Mon compte',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              context
                ..go(RouteName.editProfil)
                ..read<ProfileBloc>().add(ProfileUpdateStarted());
            },
            child: const Row(
              children: [
                Text('Modifier'),
                SizedBox(
                  width: 3,
                ),
                Icon(Icons.settings),
              ],
            ),
          ),
        ),
      ],
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
                buildWhen: (previous, current) => previous.user != current.user,
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
                        UserProfilePictureWidget(),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            state.user?.lastName ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: 16.sp),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informations générales',
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            UserInformationWidget(
                              label: 'Email :',
                              value: user.email,
                            ),
                            if (user.phone != null)
                              UserInformationWidget(
                                label: 'Téléphone :',
                                value: user.phone,
                              ),
                            if (user.phone == null)
                              const UserInformationWidget(
                                label: 'Téléphone :',
                                value: '0345665445',
                              ),
                            if (createdAt != null)
                              UserInformationWidget(
                                label: 'Date de création :',
                                value: DateFormat('dd/MM/yyyy')
                                    .format(createdAt.toLocal()),
                              ),
                            if (createdAt == null)
                              const UserInformationWidget(
                                label: 'Date de création :',
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
    );
  }
}
