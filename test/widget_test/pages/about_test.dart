import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weinday/ui/ds/molecules/custom_bottom_nav.dart';
import 'package:weinday/ui/pages/about.dart';


void main() {
  testWidgets('About page displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: About(),
      ),
    );

    // Verify the presence of the image
    expect(find.byType(Image), findsOneWidget);

    // Verify the presence of the main title
    expect(find.text('W E I N D A Y'), findsOneWidget);

    // Verify the presence of the subtitle
    expect(find.text('Una aplicación creada por Weincode'), findsOneWidget);

    // Verify the presence of the button
    expect(find.text('Ir a canal de Youtube'), findsOneWidget);

    // Verify the presence of the CustomBottomNav
    expect(find.byType(CustomBottomNav), findsOneWidget);
  });


}