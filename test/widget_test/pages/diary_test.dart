import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weinday/ui/locale/labels.dart';
import 'package:weinday/ui/pages/diary.dart';
import 'package:weinday/ui/ds/molecules/custom_bottom_nav.dart';

void main() {
  testWidgets('Diary page displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Diary(),
      ),
    );

    // Verify the presence of the main title
    expect(find.text('Reporte de tus actividades'), findsOneWidget);

    // Verify the presence of the image
    expect(find.byType(Image), findsOneWidget);

    // Verify the presence of the dropdown menu
    expect(find.byType(DropdownMenu<String>), findsOneWidget);

    // Verify the presence of the text form field
    expect(find.byType(TextFormField), findsOneWidget);

    // Verify the presence of the calendar button
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);

    // Verify the presence of the submit button
    expect(find.text(WeinDayCopys.submitActivityLabel), findsOneWidget);

    // Verify the presence of the CustomBottomNav
    expect(find.byType(CustomBottomNav), findsOneWidget);
  });

}