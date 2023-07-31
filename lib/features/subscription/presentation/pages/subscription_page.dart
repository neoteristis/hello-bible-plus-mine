import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';
import 'package:gpt/features/container/pages/section/presentation/pages/section_page.dart';
import 'package:gpt/features/subscription/presentation/bloc/subscription_bloc.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/logo.dart';
import '../../../../l10n/function.dart';
import '../widgets/widgets.dart';

import 'package:go_router/go_router.dart';
import '../../../../core/widgets/scaffold_with_background.dart';

class SubscriptionPage extends StatefulWidget {

  static const String route = 'subscription';

  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(SubscriptionFetched());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      addBackgroundImage: false,
      onPop: () {
        context.go('/${SectionPage.route}');
      },
      title: dict(context).subscribe,
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        buildWhen: (previous, current) =>
            previous.paymentDataStatus != current.paymentDataStatus,
        builder: (context, state) {
          return Stack(
            children: [
              if (state.paymentDataStatus == Status.loading)
                const Align(
                  alignment: Alignment.center,
                  child: CustomProgressIndicator(),
                ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    color: const Color(0xFFEFBB56),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Logo(
                      size: Size(60, 60),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'HELLOBIBLE+ PREMIUM',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...access.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    size: 12,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    e,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SubscriptionsListWidget(),
                    // const SubscriptionItem(
                    //   isActive: true,
                    //   interval: 'Abonnement Annuel',
                    //   expirationDate: '26/06/2024',
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // const SubscriptionItem(
                    //   interval: 'Hebdomadaire',
                    //   annualInterval: '363,5 \$',
                    //   unitAmount: '6,99\$',
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      dict(context)
                          .automaticRenewalAfterTheEndOfTheSubscription,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  const SubscriptionItem({
    super.key,
    this.isActive = false,
    required this.interval,
    this.expirationDate,
    this.annualInterval,
    this.unitAmount,
  });

  final bool? isActive;
  final String interval;
  final String? expirationDate;
  final String? annualInterval;
  final String? unitAmount;

  @override
  Widget build(BuildContext context) {
    const yellow = Color(0xFFEFBB56);
    const grey = Color(0xFF303030);
    return Container(
      decoration: BoxDecoration(
        color: isActive! ? const Color(0xFF101520) : Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isActive! ? yellow : grey,
        ),
      ),
      child: ListTile(
        // contentPadding: EdgeInsets.zero
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        leading: Icon(
          isActive! ? Icons.check_circle : Icons.check_circle_outline,
          color: isActive! ? yellow : grey,
        ),
        title: Text(
          interval,
          style: TextStyle(
            color: isActive! ? yellow : grey,
          ),
        ),
        subtitle: Text(
          isActive! ? 'Expire le $expirationDate' : '$annualInterval',
          style: TextStyle(
            color: isActive! ? Colors.white : grey,
          ),
        ),
        trailing:
            (isActive! || unitAmount == null) ? null : Text('$unitAmount'),
      ),
    );
  }
}

List<String> access = [
  'Réactions rapides',
  'Assistance multilingue',
  'Requêtes illimités',
  'Support prioritaire',
  'Basé sur GPT-4',
];

// class SubscriptionPage extends StatefulWidget {
//   const SubscriptionPage({super.key});

//   @override
//   State<SubscriptionPage> createState() => _SubscriptionPageState();
// }

// class _SubscriptionPageState extends State<SubscriptionPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SubscriptionBloc>().add(SubscriptionFetched());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SubscriptionBloc, SubscriptionState>(
//       listenWhen: (previous, current) =>
//           previous.checkCodeStatus != current.checkCodeStatus,
//       listener: (context, state) {
//         if (state.checkCodeStatus == Status.loaded) {
//           context.read<AuthBloc>().add(AuthSuccessfullyLogged());
//         }
//       },
//       child: SafeArea(
//         child: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView(
//               children: const [
//                 SubscriptionsListWidget(),
//                 FreeOfferOptionButtonWidget(),
//                 Text('Ou'),
//                 CodeRegistrationInput(),
//                 InvalidCodeWidget(),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 CheckCodeButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
