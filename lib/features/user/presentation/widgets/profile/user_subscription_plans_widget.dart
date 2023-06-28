import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          'Abonnement',
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
        const UserInformationWidget(
          label: 'Statut abonnement :',
          value: 'Actif',
        ),
        const UserInformationWidget(
          label: 'Date abonnement :',
          value: '27/05/2023',
        ),
        const UserInformationWidget(
          label: 'Type abonnement :',
          value: 'Premium Annuel',
          addBackground: true,
        ),
        const UserInformationWidget(
          label: 'Renouvellement :',
          value: '27/05/2023',
        ),
      ],
    );
  }
}
