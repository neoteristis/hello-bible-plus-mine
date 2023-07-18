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
      group('has unclosed bracket', () {
        test(
          'true',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne, Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" (Matthieu 6:9-13';
            const expected = true;
            final res = test.hasUnclosedParenthesis;
            expect(res, expected);
          },
        );

        test(
          'true',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne(Matthieu 6:9-13). Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" (Matthieu 6:9-13';
            const expected = true;
            final res = test.hasUnclosedParenthesis;
            expect(res, expected);
          },
        );
        test(
          'false here',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne(Matthieu 6:9-13). Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" (Matthieu 6:9-13)';
            const expected = false;
            final res = test.hasUnclosedParenthesis;
            expect(res, expected);
          },
        );
        test(
          'false here',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne(Matthieu 6:9-13). Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" (Matthieu 6:9-13)';
            const expected = false;
            final res = test.hasUnclosedParenthesis;
            expect(res, expected);
          },
        );
        test(
          'false',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne, Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" (Matthieu 6:9-13).';
            const expected = false;
            final res = test.hasUnclosedParenthesis;
            expect(res, expected);
          },
        );
      });

      group('has unclosed curly brace', () {
        test(
          'true',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne, Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" {Matthieu 6:9-13';
            const expected = true;
            final res = test.hasUnclosedCurlyBrace;
            expect(res, expected);
          },
        );

        test(
          'true',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne{Matthieu 6:9-13}. Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" {Matthieu 6:9-13';
            const expected = true;
            final res = test.hasUnclosedCurlyBrace;
            expect(res, expected);
          },
        );
        test(
          'false here',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne{Matthieu 6:9-13}. Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" {Matthieu 6:9-13}';
            const expected = false;
            final res = test.hasUnclosedCurlyBrace;
            expect(res, expected);
          },
        );
        test(
          'false',
          () {
            const test =
                'Jésus nous a enseigné à prier : Dans le Sermon sur la montagne, Jésus a donné à ses disciples le modèle de prière connu sous le nom de "Notre Père" {Matthieu 6:9-13}.';
            const expected = false;
            final res = test.hasUnclosedCurlyBrace;
            expect(res, expected);
          },
        );
      });
    },
  );
}
