import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:input_validation_demo/main.dart';

void main() {
  testWidgets('demonstrates the example flow', (tester) async {
    await tester.pumpWidget(const ValidationApp());
    expect(find.byType(Scaffold), findsOneWidget);
    final submit = find.text('Validate & Register');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();
    expect(
      find.text('Please correct validation errors on the form.'),
      findsOneWidget,
    );
  });
}
