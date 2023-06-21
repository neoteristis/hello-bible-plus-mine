import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/routes/route_name.dart';
import 'package:gpt/core/widgets/logo.dart';
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
  });

  final Widget body;
  final VoidCallback? onPop;
  final String? title;
  final String? titleLarge;
  final bool? goBackSocialConnect;
  final Widget? bodyLarge;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      onPop: onPop,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 90,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: const Center(
                            child: Logo(
                              size: Size(54, 54),
                            ),
                          ),
                        ),
                        Text(
                          titleLarge ?? 'Bonjour ! \nbienvenue sur HelloBible+',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          title ??
                              'Continuez pour créer votre compte ou se connecter',
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
                              context.go(RouteName.registration);
                            } else {
                              context.go(RouteName.email);
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
                                ? 'Ou continuer avec les réseaux sociaux'
                                : 'Ou continuer avec mon adresse email',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        TermsUse(),
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
