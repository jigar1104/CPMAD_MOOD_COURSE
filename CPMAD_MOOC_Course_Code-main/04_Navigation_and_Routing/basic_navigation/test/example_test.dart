import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:basic_navigation/main.dart';

void main() {
  testWidgets('demonstrates the example flow', (tester) async {
    await tester.pumpWidget(const BasicNavApp());
    expect(find.byType(Scaffold), findsOneWidget);
    await tester.tap(find.text('Open registration'));
    await tester.pumpAndSettle();
    expect(find.text('Registration'), findsOneWidget);
    await tester.tap(find.text('Back to login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue to dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('Dashboard'), findsOneWidget);
    expect(
      Navigator.of(tester.element(find.byType(Scaffold))).canPop(),
      isFalse,
    );
  });
}
