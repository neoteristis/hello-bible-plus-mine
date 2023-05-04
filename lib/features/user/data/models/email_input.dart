import 'package:gpt/core/extension/string_extension.dart';

import '../../../../core/helper/formz.dart';

enum EmailValidationError { empty, invalid }

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isEmpty == true) {
      return EmailValidationError.empty;
    } else if (value != null && !value.isEmail) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
    // return value?.isNotEmpty == true ? null : EmailValidationError.empty;
  }
}

extension EVDExtension on EmailValidationError {
  String get text {
    switch (this) {
      case EmailValidationError.empty:
        return 'Veuillez entrer votre adresse email';
      case EmailValidationError.invalid:
        return 'Veuillez entrer un valide adresse email ';
    }
  }
}
