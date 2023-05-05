import 'package:flutter_test/flutter_test.dart';
import 'package:gpt/core/extension/string_extension.dart';

void main() {
  group(
    'String extension',
    () {
      test(
        'Capitalization',
        () async {
          const test = 'this is my string.';
          const expected = 'This is my string.';
          final res = test.capitalize;
          expect(res, expected);
        },
      );

      test(
        'isEmail',
        () async {
          const test = 'misa@gmail.com';
          const expected = true;
          final res = test.isEmail;
          expect(res, expected);
        },
      );

      test(
        'isNotEmail',
        () async {
          const test = 'misa@gmail';
          const expected = false;
          final res = test.isEmail;
          expect(res, expected);
        },
      );
    },
  );
}
