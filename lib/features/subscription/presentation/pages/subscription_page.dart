import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/subscription/domain/usecases/payment_intent_usecase.dart';
import 'package:gpt/features/subscription/presentation/bloc/subscription_bloc.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {
          context
              .read<SubscriptionBloc>()
              .add(SubscriptionPaymentDataRequested(1000));
        },
        child: Text('pay now'),
      ),
    ));
  }
}
