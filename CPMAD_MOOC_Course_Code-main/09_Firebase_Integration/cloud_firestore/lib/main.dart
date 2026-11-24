import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'student_record.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    FirestoreApp(
      initialize: () async {
        await initializeCourseFirebase();
        return FirebaseFirestore.instance;
      },
    ),
  );
}

class FirestoreApp extends StatelessWidget {
  const FirestoreApp({super.key, required this.initialize});

  final Future<FirebaseFirestore> Function() initialize;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FirestoreHome(initialize: initialize));
  }
}

class FirestoreHome extends StatefulWidget {
  const FirestoreHome({super.key, required this.initialize});

  final Future<FirebaseFirestore> Function() initialize;

  @override
  State<FirestoreHome> createState() => _FirestoreHomeState();
}

class _FirestoreHomeState extends State<FirestoreHome> {
  late final _connection = widget.initialize();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _connection,
      builder: (context, snapshot) {
        final firestore = snapshot.data;
        if (firestore != null) return RecordsScreen(firestore: firestore);
        return Scaffold(
          appBar: AppBar(title: const Text('Cloud Firestore')),
          body: Center(
            child: snapshot.hasError
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key, required this.firestore});

  final FirebaseFirestore firestore;

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  late final _records = widget.firestore.collection('students');
  late final _changes = _records.snapshots();
  bool _busy = false;

  Future<void> _perform(Future<void> Function() operation) async {
    setState(() => _busy = true);
    try {
      await operation();
    } catch (error) {
      _showMessage('Firestore request failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _edit([StudentRecord? record]) async {
    setState(() => _busy = true);
    final input = await showDialog<StudentRecord>(
      context: context,
      builder: (context) => RecordForm(record: record),
    );
    if (!mounted) return;
    if (input == null) {
      setState(() => _busy = false);
      return;
    }

    await _perform(() async {
      if (record == null) {
        await _records.add(input.toMap());
      } else {
        await _records.doc(record.id).update(input.toMap());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Firestore'),
        actions: [
          IconButton(
            tooltip: 'Read once',
            onPressed: _busy
                ? null
                : () => _perform(() async {
                    final result = await _records.get();
                    _showMessage(
                      'One-time read returned ${result.size} records.',
                    );
                  }),
            icon: const Icon(Icons.cloud_download_outlined),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _changes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Could not read students: ${snapshot.error}'),
            );
          }
          final documents = snapshot.data?.docs;
          if (documents == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (documents.isEmpty) {
            return const Center(
              child: Text('No student records. Add one to begin.'),
            );
          }

          return ListView(
            children: [
              for (final doc in documents)
                _buildRecord(StudentRecord.fromMap(doc.id, doc.data())),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _busy ? null : () => _edit(),
        tooltip: 'Add student',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecord(StudentRecord record) => ListTile(
    key: ValueKey(record.id),
    title: Text(record.name),
    subtitle: Text('${record.course} · ${record.grade}%'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Edit student',
          onPressed: _busy ? null : () => _edit(record),
          icon: const Icon(Icons.edit_outlined),
        ),
        IconButton(
          tooltip: 'Delete student',
          onPressed: _busy
              ? null
              : () => _perform(() => _records.doc(record.id).delete()),
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    ),
  );
}

class RecordForm extends StatefulWidget {
  const RecordForm({super.key, this.record});

  final StudentRecord? record;

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.record?.name);
  late final _course = TextEditingController(text: widget.record?.course);
  late final _grade = TextEditingController(
    text: widget.record?.grade.toString(),
  );

  @override
  void dispose() {
    _name.dispose();
    _course.dispose();
    _grade.dispose();
    super.dispose();
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Enter a value' : null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.record == null ? 'Add student' : 'Edit student'),
      scrollable: true,
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: _required,
            ),
            TextFormField(
              controller: _course,
              decoration: const InputDecoration(labelText: 'Course'),
              validator: _required,
            ),
            TextFormField(
              controller: _grade,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Grade'),
              validator: (value) {
                final grade = double.tryParse(value?.trim() ?? '');
                if (grade == null ||
                    !grade.isFinite ||
                    grade < 0 ||
                    grade > 100) {
                  return 'Enter a number from 0 to 100';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!_form.currentState!.validate()) return;
            Navigator.pop(
              context,
              StudentRecord(
                id: widget.record?.id ?? '',
                name: _name.text.trim(),
                course: _course.text.trim(),
                grade: double.parse(_grade.text.trim()),
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
