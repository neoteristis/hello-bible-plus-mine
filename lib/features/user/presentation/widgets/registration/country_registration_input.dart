import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../../../core/helper/countries_list.dart';
import '../../bloc/registration_bloc/registration_bloc.dart';

import 'package:gpt/core/models/required_input.dart';

class CountryRegistrationInput extends StatefulWidget {
  const CountryRegistrationInput({super.key});

  @override
  State<CountryRegistrationInput> createState() =>
      _CountryRegistrationInputState();
}

class _CountryRegistrationInputState extends State<CountryRegistrationInput> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TypeAheadField(
          hideSuggestionsOnKeyboardHide: true,
          keepSuggestionsOnLoading: false,
          hideOnEmpty: true,
          debounceDuration: const Duration(milliseconds: 1000),
          loadingBuilder: (context) => const SizedBox(
              height: 100, child: Center(child: CircularProgressIndicator())),
          textFieldConfiguration: TextFieldConfiguration(
            controller: controller,
            autofocus: false,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(fontStyle: FontStyle.normal),
            decoration: InputDecoration(
              hintText: 'ex France...',
              hintStyle:
                  TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
              errorText: state.registrationInputs.country.isNotValid
                  ? state.registrationInputs.country.displayError?.text
                  : null,
            ),
          ),
          suggestionsCallback: (pattern) async {
            final suggest = countriesListJson.where((element) =>
                element['name']!.toLowerCase().contains(pattern.toLowerCase()));

            return suggest;
          },
          itemBuilder: (context, country) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(country['name'] ?? ''),
            );
          },
          onSuggestionSelected: (country) {
            setState(() {
              controller.text = country['name'] ?? '';
            });
            if (country['name'] != null) {
              context
                  .read<RegistrationBloc>()
                  .add(RegistrationCountryChanged(country['name']!));
            }
          },
        );
      },
    );
  }
}
