import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/theme/theme.dart';

import 'core/bloc/obscure_text/obscure_text_cubit.dart';
import 'core/routes/route_name.dart';
import 'core/routes/router.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/chat/presentation/bloc/donation_bloc/donation_bloc.dart';
import 'features/chat/presentation/bloc/historical_bloc/historical_bloc.dart';
import 'features/introduction/presentation/bloc/introduction_bloc.dart';
import 'features/subscription/presentation/bloc/subscription_bloc.dart';
import 'features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/user/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'injections.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DonationBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegistrationBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(AuthStarted()),
        ),
        BlocProvider(create: (context) => getIt<HistoricalBloc>()
            // ..add(HistoricalFetched()),
            ),
        BlocProvider(
          create: (context) => getIt<SubscriptionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<IntroductionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ObscureTextCubit>(),
        ),
      ],
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (previous, current) => previous.theme != current.theme,
        builder: (context, state) {
          return BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) => previous.route != current.route,
            builder: (context, authState) {
              final route = authState.route;
              // const route = RouteName.login;
              return MaterialApp.router(
                title: 'hello bible +',
                theme: state.theme ?? theme(null),
                debugShowCheckedModeBanner: false,
                // home: const ChatPage(),
                // home: const RegistrationPage(),
                routeInformationParser: routers[route]?.routeInformationParser,
                routerDelegate: routers[route]?.routerDelegate,
                routeInformationProvider:
                    routers[route]?.routeInformationProvider,
              );
            },
          );
        },
      ),
    );
  }
}
