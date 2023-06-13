import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/historical_page.dart';
import '../../features/subscription/presentation/pages/subscription_page.dart';
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
                  path: 'subscription',
                  builder: (context, state) => const SubscriptionPage(),
                ),
              ]),
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
        ]),
  ],
);
