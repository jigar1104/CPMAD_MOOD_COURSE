import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:getx_example/main.dart';

void main() {
  testWidgets('demonstrates the example flow', (tester) async {
    await tester.pumpWidget(const GetXApp());
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('GetX Reactive Management'), findsOneWidget);
    final increment = find.byIcon(Icons.add);
    expect(increment, findsWidgets);
    await tester.tap(increment.first);
    await tester.pump();
    expect(find.textContaining('1'), findsWidgets);
  });
}
