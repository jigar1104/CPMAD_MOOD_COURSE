import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:named_routes_demo/main.dart';

void main() {
  testWidgets('demonstrates the example flow', (tester) async {
    await tester.pumpWidget(const NamedRoutesApp());
    expect(find.byType(Scaffold), findsOneWidget);
    await tester.tap(find.text('Open login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Flutter learner'), findsOneWidget);
    Navigator.of(tester.element(find.byType(Scaffold))).pop();
    await tester.pumpAndSettle();
    expect(find.text('Open login'), findsOneWidget);
  });
}
