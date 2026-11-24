import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_setup/main.dart';

void main() {
  testWidgets('demonstrates the example flow', (tester) async {
    await tester.pumpWidget(const FirebaseSetupApp());
    expect(find.byType(Scaffold), findsOneWidget);
    await tester.tap(find.text('Initialize Firebase'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Firebase setup required'), findsOneWidget);
  });
}
