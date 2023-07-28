import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
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
      initialLocation: SplashScreen.route,
      refreshListenable:
          GoRouterRefreshStream(GetIt.instance.get<AuthBloc>().stream),
      routes: [
        GoRoute(
          path: SplashScreen.route,
          builder: (context, splash) => const SplashScreen(),
          redirect: (context, state) async {
            final authenticationStatus = context.read<AuthBloc>().state.authenticationStatus;
            if (state.fullPath == SplashScreen.route) {
              switch (authenticationStatus) {
                case AuthStatus.authenticated:
                  return '${SplashScreen.route}${HomePage.route}';
                case AuthStatus.unauthenticated:
                  return '${SplashScreen.route}${LandingPage.route}';
                default:
                  return null;
              }
            }
            return null;
          },
          routes: [
            ///Unauthenticated
            GoRoute(
              path: LandingPage.route,
              builder: (context, state) => const LandingPage(),
              routes: [
                GoRoute(
                  path: RegistrationPage.route,
                  builder: (context, state) => const RegistrationPage(),
                  routes: [
                    GoRoute(
                      path: EmailInputPage.route,
                      builder: (context, state) => const EmailInputPage(),
                      routes: [
                        GoRoute(
                          path: PasswordInputPage.route,
                          builder: (context, state) =>
                              const PasswordInputPage(),
                        ),
                        GoRoute(
                          path: CreatePasswordInputPage.route,
                          builder: (context, state) =>
                              const CreatePasswordInputPage(),
                        ),
                        GoRoute(
                          path: NameAndPictureInputPage.route,
                          builder: (context, state) =>
                              const NameAndPictureInputPage(),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: SubscriptionPage.route,
                      builder: (context, state) => const SubscriptionPage(),
                    ),
                  ],
                ),
              ],
            ),

            ///Authenticated
            GoRoute(
              path: HomePage.route,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: ChatPage.route,
                  builder: (context, state) => const ChatPage(),
                ),
                GoRoute(
                  path: HistoricalPage.route,
                  builder: (context, state) => const HistoricalPage(),
                ),
                GoRoute(
                  path: SubscriptionPage.route,
                  builder: (context, state) => const SubscriptionPage(),
                ),
                GoRoute(
                  path: ProfilePage.route,
                  builder: (context, state) => const ProfilePage(),
                  routes: [
                    GoRoute(
                      path: EditProfilePage.route,
                      builder: (context, state) => const EditProfilePage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: NotificationsPage.route,
                  builder: (context, state) => const NotificationsPage(),
                  routes: [
                    GoRoute(
                      path: ManageNotificationsPage.route,
                      builder: (context, state) =>
                          const ManageNotificationsPage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: ContactUsPage.route,
                  builder: (context, state) => const ContactUsPage(),
                ),
                GoRoute(
                  path: AboutPage.route,
                  builder: (context, state) => const AboutPage(),
                ),
                GoRoute(
                  path: HelpPage.route,
                  builder: (context, state) => const HelpPage(),
                ),
                GoRoute(
                  path: UsageGeneralConditionPage.route,
                  builder: (context, state) =>
                      const UsageGeneralConditionPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
