import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/log.dart';
import 'package:gpt/features/home/presentation/page/home_page.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/historical_page.dart';
import '../../features/contact_us/presentation/pages/contact_us_page.dart';
import '../../features/more/presentation/pages/about_page.dart';
import '../../features/more/presentation/pages/help_page.dart';
import '../../features/more/presentation/pages/usage_general_condition_page.dart';
import '../../features/notification/presentation/pages/manage_notifications_page.dart';
import '../../features/notification/presentation/pages/notifications_page.dart';
import '../../features/subscription/presentation/pages/subscription_page.dart';
import '../../features/user/presentation/pages/create_password_input_page.dart';
import '../../features/user/presentation/pages/email_input_page.dart';
import '../../features/user/presentation/pages/name_and_picture_input_page.dart';
import '../../features/user/presentation/pages/passwod_input_page.dart';
import '../../features/user/presentation/pages/profile/edit_profile_page.dart';
import '../../features/user/presentation/pages/profile/profile_page.dart';
import '../../features/user/presentation/pages/registration_page.dart';
import '../../features/introduction/presentation/pages/landing_page.dart';
import '../../splash_screen.dart';
import 'go_router_refresh_stream.dart';

GoRouter get route => GoRouter(
      initialLocation: '/',
      refreshListenable:
          GoRouterRefreshStream(GetIt.instance.get<AuthBloc>().stream),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, splash) => const SplashScreen(),
          redirect: (context, state) async {
            final loggedStatus = context.read<AuthBloc>().state.loggedStatus;
            if(state.fullPath == '/'){
              switch (loggedStatus) {
                case AuthStatus.authenticated:
                  return '/home';
                case AuthStatus.unauthenticated:
                  return '/landing';
                default:
                  return null;
              }
            }
          },
          routes: [
            ///Unauthenticated
            GoRoute(
              path: 'landing',
              builder: (context, state) => const LandingPage(),
              routes: [
                GoRoute(
                  path: 'registration',
                  builder: (context, state) => const RegistrationPage(),
                  routes: [
                    GoRoute(
                      path: 'email',
                      builder: (context, state) => const EmailInputPage(),
                      routes: [
                        GoRoute(
                          path: 'password',
                          builder: (context, state) =>
                              const PasswordInputPage(),
                        ),
                        GoRoute(
                          path: 'newPassword',
                          builder: (context, state) =>
                              const CreatePasswordInputPage(),
                        ),
                        GoRoute(
                          path: 'namePicture',
                          builder: (context, state) =>
                              const NameAndPictureInputPage(),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'subscription',
                      builder: (context, state) => const SubscriptionPage(),
                    ),
                  ],
                ),
              ],
            ),

            ///Authenticated
            GoRoute(
              path: 'home',
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'chat',
                  builder: (context, state) => const ChatPage(),
                ),
                GoRoute(
                  path: 'historical',
                  builder: (context, state) => const HistoricalPage(),
                ),
                GoRoute(
                  path: 'subscribe',
                  builder: (context, state) => const SubscriptionPage(),
                ),
                GoRoute(
                  path: 'profile',
                  builder: (context, state) => const ProfilePage(),
                  routes: [
                    GoRoute(
                      path: 'edit-profile',
                      builder: (context, state) => const EditProfilePage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'notif',
                  builder: (context, state) => const NotificationsPage(),
                  routes: [
                    GoRoute(
                      path: 'manageNotif',
                      builder: (context, state) =>
                          const ManageNotificationsPage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'contact-us',
                  builder: (context, state) => const ContactUsPage(),
                ),
                GoRoute(
                  path: 'about',
                  builder: (context, state) => const AboutPage(),
                ),
                GoRoute(
                  path: 'help',
                  builder: (context, state) => const HelpPage(),
                ),
                GoRoute(
                  path: 'usage-general-conditions',
                  builder: (context, state) =>
                      const UsageGeneralConditionPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
