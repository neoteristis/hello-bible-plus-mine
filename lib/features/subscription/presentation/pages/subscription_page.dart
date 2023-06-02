import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/subscription/presentation/bloc/subscription_bloc.dart';

import '../../../../core/widgets/rounded_loading_button.dart';
import '../../../user/presentation/widgets/registration/widget_registration.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SubscriptionsListWidget(),
              Container(
                decoration: BoxDecoration(),
                child: Text('Offre gratuit pour l\'instant'),
              ),
              Text('Ou'),
              CodeRegistrationInput(),
              InvalidCodeWidget(),
              SizedBox(
                height: 10,
              ),
              RoundedLoadingButton(
                controller: RoundedLoadingButtonController(),
                onPressed: () {},
                child: Text('valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
