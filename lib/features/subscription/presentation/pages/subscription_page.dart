import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/subscription/presentation/bloc/subscription_bloc.dart';

import '../../../../core/constants/status.dart';
import '../../../user/presentation/bloc/auth_bloc/auth_bloc.dart';
import '../widgets/widgets.dart';

class SubscriptionPage extends StatefulWidget {
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
    return BlocListener<SubscriptionBloc, SubscriptionState>(
      listenWhen: (previous, current) =>
          previous.checkCodeStatus != current.checkCodeStatus,
      listener: (context, state) {
        if (state.checkCodeStatus == Status.loaded) {
          context.read<AuthBloc>().add(AuthSuccessfullyLogged());
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: const [
                SubscriptionsListWidget(),
                FreeOfferOptionButtonWidget(),
                Text('Ou'),
                CodeRegistrationInput(),
                InvalidCodeWidget(),
                SizedBox(
                  height: 10,
                ),
                CheckCodeButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FreeOfferOptionButtonWidget extends StatelessWidget {
  const FreeOfferOptionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AuthBloc>().add(AuthSuccessfullyLogged()),
      child: Container(
        decoration: const BoxDecoration(),
        child: const Text('Offre gratuit pour l\'instant'),
      ),
    );
  }
}
