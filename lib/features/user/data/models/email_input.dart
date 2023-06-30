import 'package:flutter/material.dart';
import 'package:gpt/core/extension/string_extension.dart';
import 'package:gpt/l10n/function.dart';

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
  String text(BuildContext context) {
    switch (this) {
      case EmailValidationError.empty:
        return dict(context).pleaseEnterYourEmailAddress;
      case EmailValidationError.invalid:
        return dict(context).pleaseEnterAValidEmailAddress;
    }
  }
}
