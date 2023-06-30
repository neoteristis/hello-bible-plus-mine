// Define input validation errors
import 'package:flutter/material.dart';

import '../../l10n/function.dart';
import '../helper/formz.dart';

enum RequiredInputError { empty }

// Extend FormzInput and provide the input type and error type.
class RequiredInput extends FormzInput<String, RequiredInputError> {
  // Call super.pure to represent an unmodified form input.
  const RequiredInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RequiredInput.dirty(String value) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  RequiredInputError? validator(String value) {
    return value.isEmpty ? RequiredInputError.empty : null;
  }
}

extension RIExtension on RequiredInputError {
  String text(BuildContext context) {
    switch (this) {
      case RequiredInputError.empty:
        return dict(context).thisFieldIsRequired;
    }
  }
}
