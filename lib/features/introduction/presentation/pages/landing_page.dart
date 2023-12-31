import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/features/user/presentation/pages/registration_page.dart';
import 'package:gpt/splash_screen.dart';

import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_dots_indicator.dart';
import '../../../../core/widgets/logo_with_text.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../../l10n/function.dart';
import '../bloc/introduction_bloc.dart';
import '../widgets/page_view_child.dart';

class LandingPage extends StatelessWidget {
  static const String route = 'landing';

  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .015,
                ),
                child: const LogoWithText(),
              ),
              Expanded(
                child: BlocBuilder<IntroductionBloc, IntroductionState>(
                  buildWhen: (previous, current) =>
                      previous.controller != current.controller,
                  builder: (context, state) {
                    return PageView(
                      controller: state.controller,
                      // physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (value) => context
                          .read<IntroductionBloc>()
                          .add(IntroductionPageChanged(value)),
                      children: [
                        PageViewChild(
                          images: const ['assets/images/landing_1.svg'],
                          title: dict(context).liveTheWordOfGod,
                          body: dict(context).simpleAndEffectiveTool,
                        ),
                        PageViewChild(
                          images: const [
                            'assets/images/landing_2.svg',
                          ],
                          title: dict(context).answersToYourSpiritualQuestions,
                          body: dict(context).findAnswersToYourQuestions,
                        ),
                        PageViewChild(
                          images: const ['assets/images/landing_3.svg'],
                          extendImage: false,
                          title: dict(context).learnEasily,
                          body: dict(context).learnTheBibleEveryDay,
                        ),
                      ],
                    );
                  },
                ),
              ),
              BlocBuilder<IntroductionBloc, IntroductionState>(
                buildWhen: (previous, current) =>
                    previous.currentPage != current.currentPage,
                builder: (context, state) {
                  return CustomDotsIndicator(
                    position: state.currentPage,
                  );
                },
              ),
              BlocBuilder<IntroductionBloc, IntroductionState>(
                buildWhen: (previous, current) =>
                    previous.currentPage != current.currentPage,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomButtonWidget(ButtonType.black).build(
                      context: context,
                      onPressed: () {
                        if (state.currentPage == 2) {
                          context
                              .read<IntroductionBloc>()
                              .add(IntroductionTerminated());
                          context.go('${SplashScreen.route}${LandingPage.route}/${RegistrationPage.route}');
                        } else {
                          context
                              .read<IntroductionBloc>()
                              .add(IntroductionContinueSubmitted());
                        }
                      },
                      label: state.currentPage == 2
                          ? dict(context).begin
                          : dict(context).keepup,
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
