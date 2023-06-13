import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../user/presentation/bloc/auth_bloc/auth_bloc.dart';

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
