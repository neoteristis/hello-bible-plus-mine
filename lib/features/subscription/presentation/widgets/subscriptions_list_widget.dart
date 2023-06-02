import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/status.dart';
import '../bloc/subscription_bloc.dart';

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
              child: CircularProgressIndicator(),
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
                            // final id = sub.id;
                            // if (id != null) {
                            //   context
                            //       .read<SubscriptionBloc>()
                            //       .add(SubscriptionUpdated(subscriptionId: sub.id!));
                            // }
                            // context
                            //     .read<SubscriptionBloc>()
                            //     .add(SubscriptionPaymentDataRequested(1000));
                          },
                          child: ListTile(
                            title: Text(
                              '${sub.unitAmount} ${sub.currency} per ${sub.intervalCount} ${sub.interval}',
                            ),
                          ),
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
