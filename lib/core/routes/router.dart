import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/historical_page.dart';
import '../../features/notification/presentation/pages/manage_notifications_page.dart';
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
import 'route_name.dart';

Map<String, GoRouter> routers = {
  RouteName.login: _routerForLogin,
  RouteName.logged: _routerForLogged,
  RouteName.splash: _routerSplash,
};

final _routerSplash = GoRouter(
  initialLocation: RouteName.home,
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const SplashScreen(),
    )
  ],
);

final _routerForLogin = GoRouter(
  initialLocation: RouteName.home,
  routes: [
    GoRoute(
        path: RouteName.home,
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
                    builder: (context, state) => const PasswordInputPage(),
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
        ]),
  ],
);

final _routerForLogged = GoRouter(
  initialLocation: RouteName.home,
  routes: [
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const ChatPage(),
      routes: [
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
            ]),
        GoRoute(
          path: 'manageNotif',
          builder: (context, state) => const ManageNotificationsPage(),
        ),
      ],
    ),
  ],
);
