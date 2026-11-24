import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stateful_stateless_demo/main.dart';

void main() {
  testWidgets('renders the example screen', (tester) async {
    await tester.pumpWidget(const WidgetTypesApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
