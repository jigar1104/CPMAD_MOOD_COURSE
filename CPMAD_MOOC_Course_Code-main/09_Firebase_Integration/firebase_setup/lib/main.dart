import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FirebaseSetupApp());
}

class FirebaseSetupApp extends StatelessWidget {
  const FirebaseSetupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: FirebaseSetupScreen());
  }
}

class FirebaseSetupScreen extends StatefulWidget {
  const FirebaseSetupScreen({super.key});

  @override
  State<FirebaseSetupScreen> createState() => _FirebaseSetupScreenState();
}

class _FirebaseSetupScreenState extends State<FirebaseSetupScreen> {
  FirebaseApp? _firebase;
  String _status = 'Configure this app, then initialize Firebase.';
  bool _busy = false;

  Future<void> _initialize() async {
    setState(() {
      _busy = true;
      _status = 'Connecting to Firebase…';
    });
    try {
      final app = await initializeCourseFirebase();
      if (!mounted) return;
      _firebase = app;
      _status = 'Firebase initialized for ${app.options.projectId}.';
    } catch (error) {
      if (mounted) _status = error.toString();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Initialization')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_status, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _busy || _firebase != null ? null : _initialize,
                child: const Text('Initialize Firebase'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
