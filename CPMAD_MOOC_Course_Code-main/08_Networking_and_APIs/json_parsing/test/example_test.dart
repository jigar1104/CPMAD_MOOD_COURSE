import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_parsing_demo/main.dart';

void main() {
  testWidgets('renders the example screen', (tester) async {
    await tester.pumpWidget(const JsonParsingApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
