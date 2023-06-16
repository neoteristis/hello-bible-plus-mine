import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/routes/route_name.dart';

import '../../../../core/widgets/background_image_full.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_dots_indicator.dart';
import '../../../../core/widgets/logo_with_text.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../bloc/introduction_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      body: Stack(
        children: [
          const Positioned(
            bottom: 10,
            left: 10,
            child: BackgroundImageFull(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: LogoWithText(),
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
                      children: const [
                        PageViewChild(
                          images: ['assets/images/landing_1.svg'],
                          title: 'Vivre la Parole de Dieu',
                          body:
                              'Un outil simple et efficace pour vous aider à vivre la Parole de Dieu',
                        ),
                        PageViewChild(
                          images: [
                            'assets/images/landing_2.svg',
                            'assets/images/landing_2_a.svg'
                          ],
                          title: 'Des réponses à vos questions spirituelles',
                          body:
                              'Trouvez des réponses à vos questions grâce à notre outil de discussion et un accompagnement',
                        ),
                        PageViewChild(
                          images: ['assets/images/landing_3.svg'],
                          title: 'Apprendre facilement',
                          body: 'Apprenez chaque jour la Bible via notre quizz',
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
                          context.go(RouteName.email);
                        } else {
                          context
                              .read<IntroductionBloc>()
                              .add(IntroductionContinueSubmitted());
                        }
                      },
                      label: state.currentPage == 2 ? 'Commencer' : 'Continuer',
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
  });

  final List<String> images;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...images
                  .map(
                    (e) => Center(
                      child: SvgPicture.asset(e),
                    ),
                  )
                  .toList(),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(
                height: 8,
              ),
              Text(body,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}
