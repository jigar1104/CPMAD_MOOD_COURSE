import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world_app/main.dart';

void main() {
  testWidgets('renders the example screen', (tester) async {
    await tester.pumpWidget(const HelloWorldApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
