import 'package:gpt/core/extension/string_extension.dart';

import '../../../../core/helper/formz.dart';
import '../../../../l10n/function.dart';

enum NumberValidationError { invalid }

class NumberInput extends FormzInput<String, NumberValidationError> {
  const NumberInput.pure() : super.pure('');
  const NumberInput.dirty([String value = '']) : super.dirty(value);

  @override
  NumberValidationError? validator(String? value) {
    if (value != null && value != '' && !value.isPhoneNumber) {
      return NumberValidationError.invalid;
    } else {
      return null;
    }
    // return value?.isNotEmpty == true ? null : EmailValidationError.empty;
  }
}

extension PNVDExtension on NumberValidationError {
  String text(context) {
    switch (this) {
      // case NumberValidationError.empty:
      //   return 'Veuillez entrer votre adresse email';
      case NumberValidationError.invalid:
        return dict(context).pleaseEnterAValidPhone;
    }
  }
}
