import 'package:flutter_test/flutter_test.dart';
import 'package:weinday/ui/helper/validators.dart';
import 'package:weinday/ui/locale/weinday_copys.dart';

void main() {
  group('validateInput', () {
    test('returns error message if input is null', () {
      expect(validateInput(null), WeinDayErrors.activityErrorLabel);
    });

    test('returns error message if input is empty', () {
      expect(validateInput(''), WeinDayErrors.activityErrorLabel);
    });

    test('returns null if input is valid', () {
      expect(validateInput('valid input'), null);
    });
  });
}