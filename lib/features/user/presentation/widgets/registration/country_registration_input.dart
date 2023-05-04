import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_multi_formatter/widgets/country_dropdown.dart';

import '../../bloc/registration_bloc/registration_bloc.dart';

class CountryRegistrationInput extends StatelessWidget {
  const CountryRegistrationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return CountryDropdown(
      printCountryName: true,
      onCountrySelected: (PhoneCountryData countryData) {
        context
            .read<RegistrationBloc>()
            .add(RegistrationEmailChanged(countryData.country ?? ''));
      },
    );
  }
}
