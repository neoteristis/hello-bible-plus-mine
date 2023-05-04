import '../helper/formz.dart';

enum UnrequiredInputValidationError { _ }

class UnrequiredInput
    extends FormzInput<String, UnrequiredInputValidationError> {
  const UnrequiredInput.pure() : super.pure('');
  const UnrequiredInput.dirty([String value = '']) : super.dirty(value);

  @override
  UnrequiredInputValidationError? validator(String? value) {
    return null;
  }
}
