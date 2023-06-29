import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';

import '../../../../core/constants/status.dart';
import '../bloc/subscription_bloc.dart';
import '../pages/subscription_page.dart';

class SubscriptionsListWidget extends StatelessWidget {
  const SubscriptionsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionBloc, SubscriptionState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(
              child: CustomProgressIndicator(),
            );
          case Status.loaded:
            final subscriptions = state.subscriptions;
            if (subscriptions == null || subscriptions.isEmpty) {
              return const Text('Empty');
            }
            return Column(
              children: [
                ...subscriptions
                    .map((sub) => GestureDetector(
                          onTap: () {
                            context
                                .read<SubscriptionBloc>()
                                .add(SubscriptionPaymentDataRequested(sub));
                          },
                          child: SubscriptionItem(
                              interval: sub.interval!,
                              annualInterval:
                                  '${sub.unitAmount} ${sub.currency}/${sub.intervalCount} ${sub.interval}'),
                        ))
                    .toList(),
              ],
            );
          case Status.failed:
            return const Center(
              child: Text('error'),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
