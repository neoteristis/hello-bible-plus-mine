import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gpt/l10n/function.dart';

import 'user_information_widget.dart';

class UserSubscriptionPlansWidget extends StatelessWidget {
  const UserSubscriptionPlansWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        UserInformationWidget(
          label: dict(context).subscriptionStatus,
          value: 'Actif',
        ),
        UserInformationWidget(
          label: dict(context).subscriptionDate,
          value: '27/05/2023',
        ),
        UserInformationWidget(
          label: dict(context).subscriptionType,
          value: 'Premium Annuel',
          addBackground: true,
        ),
        UserInformationWidget(
          label: dict(context).renewal,
          value: '27/05/2023',
        ),
      ],
    );
  }
}
