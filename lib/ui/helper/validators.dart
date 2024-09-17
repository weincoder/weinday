import 'package:weinday/ui/locale/labels.dart';

String? validateInput(value) {
  if (value == null || value.isEmpty) {
    return WeinDayErrors.activityErrorLabel;
  }
  return null;
}
