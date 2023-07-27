import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/core/routes/router.dart';
import 'package:gpt/core/theme/theme.dart';
import 'package:gpt/features/contact_us/presentation/bloc/contact_us_bloc.dart';
import 'package:gpt/features/notification/presentation/bloc/manage_notif/manage_notif_bloc.dart';

import 'core/bloc/obscure_text/obscure_text_cubit.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'features/chat/presentation/bloc/donation_bloc/donation_bloc.dart';
import 'features/chat/presentation/bloc/historical_bloc/historical_bloc.dart';
import 'features/introduction/presentation/bloc/introduction_bloc.dart';
import 'features/notification/presentation/bloc/notification_bloc.dart';
import 'features/subscription/presentation/bloc/subscription_bloc.dart';
import 'features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/user/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'features/user/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'features/user/presentation/bloc/social_connect_bloc/social_connect_bloc.dart';
import 'injections.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ThemeBloc>()..add(ThemeStarted()),
        ),
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
        BlocProvider(
          create: (context) =>
              getIt<HistoricalBloc>()..add(const HistoricalFetched()),
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
        BlocProvider(
          create: (context) => getIt<SocialConnectBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<NotificationBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ContactUsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ManageNotifBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return BlocBuilder<ThemeBloc, ThemeState>(
                buildWhen: (previous, current) =>
                    previous.themeMode != current.themeMode,
                builder: (context, state) {
                  return MaterialApp.router(
                    title: 'hello bible',
                    theme: light,
                    darkTheme: dark,
                    debugShowCheckedModeBanner: false,
                    themeMode: state.themeMode,
                    routerConfig: route,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
