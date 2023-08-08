import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/logo.dart';
import 'package:gpt/features/introduction/presentation/pages/landing_page.dart';
import 'package:gpt/features/user/presentation/pages/email_input_page.dart';
import 'package:gpt/features/user/presentation/pages/registration_page.dart';
import 'package:gpt/l10n/function.dart';
import 'package:gpt/splash_screen.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../widgets/registrations/registrations.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    required this.body,
    this.onPop,
    this.title,
    this.goBackSocialConnect = true,
    this.titleLarge,
    this.bodyLarge,
    this.hasAppBar,
  });

  final Widget body;
  final VoidCallback? onPop;
  final String? title;
  final String? titleLarge;
  final bool? goBackSocialConnect;
  final Widget? bodyLarge;
  final bool? hasAppBar;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      onPop: onPop,
      hasAppBar: hasAppBar ?? true,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Center(
                            child: Logo(
                              size: Size(54, 54),
                            ),
                          ),
                        ),
                        Text(
                          titleLarge ??
                              dict(context).goodmorningAndWelcomeToHelloBible,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          title ?? dict(context).continueToCreateYourAccount,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: bodyLarge ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        body,
                        TextButton(
                          onPressed: () {
                            if (goBackSocialConnect ?? true) {
                              context.go(
                                  '${SplashScreen.route}${LandingPage.route}/${RegistrationPage.route}');
                            } else {
                              context.go(
                                  '${SplashScreen.route}${LandingPage.route}/${RegistrationPage.route}/${EmailInputPage.route}');
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: Text(
                            goBackSocialConnect ?? true
                                ? dict(context).orContinueWithSocialNetworks
                                : dict(context).orContinueWithMyEmailAddress,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        const Expanded(
                          child: TermsUse(),
                        ),
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
