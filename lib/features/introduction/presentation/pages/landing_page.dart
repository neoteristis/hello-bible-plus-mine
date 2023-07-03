import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/routes/route_name.dart';

import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_dots_indicator.dart';
import '../../../../core/widgets/logo_with_text.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../../l10n/function.dart';
import '../bloc/introduction_bloc.dart';

class LandingPage extends StatelessWidget {
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
                          context.go(RouteName.registration);
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

class PageViewChild extends StatelessWidget {
  const PageViewChild({
    super.key,
    required this.images,
    required this.title,
    required this.body,
    this.extendImage = true,
  });

  final List<String> images;
  final String title;
  final String body;
  final bool? extendImage;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          SvgPicture.asset(
            images.first,
            // width: extendImage! ? MediaQuery.of(context).size.width : null,
            height: height * 0.4,
            color: Theme.of(context).colorScheme.secondary,
          ),
          // const Spacer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
