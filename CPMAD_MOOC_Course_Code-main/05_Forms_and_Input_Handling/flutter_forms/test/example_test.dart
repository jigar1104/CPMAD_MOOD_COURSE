import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_forms_demo/main.dart';

void main() {
  testWidgets('renders the example screen', (tester) async {
    await tester.pumpWidget(const FlutterFormsApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
