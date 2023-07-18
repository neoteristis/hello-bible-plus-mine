import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/l10n/function.dart';
import 'package:intl/intl.dart';

import '../../bloc/profile_bloc/profile_bloc.dart';
import 'user_information_widget.dart';

class UserSubscriptionPlansWidget extends StatelessWidget {
  const UserSubscriptionPlansWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        final user = state.user;
        final subscription = user?.subscription;
        if (subscription == null) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dict(context).subscription,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  // ?.copyWith(
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 14),
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            const SizedBox(
              height: 5,
            ),
            if (subscription.status != null)
              UserInformationWidget(
                label: dict(context).subscriptionStatus,
                value: subscription.status! ? 'Actif' : 'Inactif',
              ),
            if (subscription.date != null)
              UserInformationWidget(
                label: dict(context).subscriptionDate,
                value: DateFormat('dd/MM/y').format(subscription.date!),
              ),
            if (subscription.type != null)
              UserInformationWidget(
                label: dict(context).subscriptionType,
                value: subscription.type,
                addBackground: true,
              ),
            if (subscription.expiration != null)
              UserInformationWidget(
                label: dict(context).renewal,
                value: DateFormat('dd/MM/y').format(subscription.expiration!),
              ),
          ],
        );
      },
    );
  }
}
