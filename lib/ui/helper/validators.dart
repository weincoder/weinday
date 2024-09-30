import 'package:weinday/ui/locale/weinday_copys.dart';

String? validateInput(value) {
  if (value == null || value.isEmpty) {
    return WeinDayErrors.activityErrorLabel;
  }
  return null;
}
