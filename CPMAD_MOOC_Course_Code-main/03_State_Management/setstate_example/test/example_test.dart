import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setstate_example/main.dart';

void main() {
  testWidgets('demonstrates the example flow', (tester) async {
    await tester.pumpWidget(const SetStateApp());
    expect(find.byType(Scaffold), findsOneWidget);
    await tester.tap(find.byTooltip('Increment'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.text('Randomize Card Color'));
    await tester.pumpAndSettle();
    final label = tester.widget<Text>(find.text('Current Counter Value:'));
    final cards = find.ancestor(
      of: find.text('Current Counter Value:'),
      matching: find.byType(AnimatedContainer),
    );
    final card = tester.widget<AnimatedContainer>(cards.first);
    final color = (card.decoration! as BoxDecoration).color!;
    expect(
      label.style?.color,
      color.computeLuminance() > 0.179 ? Colors.black : Colors.white,
    );
  });
}
