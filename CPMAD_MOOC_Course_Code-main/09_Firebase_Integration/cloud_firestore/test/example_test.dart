import 'package:cloud_firestore_crud/main.dart';
import 'package:cloud_firestore_crud/student_record.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the missing Firebase configuration', (tester) async {
    await tester.pumpWidget(
      FirestoreApp(
        initialize: () async => throw StateError('Firebase setup required.'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Firebase setup required'), findsOneWidget);
  });

  test('round-trips a Firestore document containing a numeric grade', () {
    final record = StudentRecord.fromMap('doc-1', {
      'name': 'Taylor',
      'course': 'Flutter',
      'grade': 95,
    });
    expect(record.id, 'doc-1');
    expect(record.toMap(), {
      'name': 'Taylor',
      'course': 'Flutter',
      'grade': 95.0,
    });
  });
}
