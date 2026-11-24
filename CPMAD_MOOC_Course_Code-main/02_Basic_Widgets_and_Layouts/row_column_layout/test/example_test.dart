import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:row_column_layout_demo/main.dart';

void main() {
  testWidgets('renders the example screen', (tester) async {
    await tester.pumpWidget(const RowColumnApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
