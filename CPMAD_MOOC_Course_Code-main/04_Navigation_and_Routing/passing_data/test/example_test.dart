import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passing_data_demo/main.dart';

void main() {
  testWidgets('demonstrates the example flow', (tester) async {
    await tester.pumpWidget(const PassingDataApp());
    expect(find.byType(Scaffold), findsOneWidget);
    await tester.tap(find.text('Continue to dashboard'));
    await tester.pump();
    expect(find.text('Enter your name first.'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '  Taylor  ');
    await tester.tap(find.text('Continue to dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Taylor'), findsOneWidget);
  });
}
