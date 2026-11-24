import 'package:flutter/material.dart';

void main() {
  runApp(const PassingDataApp());
}

class PassingDataApp extends StatelessWidget {
  const PassingDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passing Data Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const SenderScreen(),
    );
  }
}

class StudentData {
  final String name;
  final String rollNumber;
  final String subject;

  StudentData({
    required this.name,
    required this.rollNumber,
    required this.subject,
  });
}

class SenderScreen extends StatefulWidget {
  const SenderScreen({super.key});

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  String _returnedFeedback = 'No feedback received yet.';

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    super.dispose();
  }

  void _sendDataAndAwaitResult() async {
    final student = StudentData(
      name: _nameController.text.trim(),
      rollNumber: _rollController.text.trim(),
      subject: 'Mastering Flutter Course',
    );

    // Push screen and wait for pop result
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute<String>(
        builder: (context) => ReceiverScreen(student: student),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _returnedFeedback = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Sender Screen'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rollController,
              decoration: const InputDecoration(
                labelText: 'Roll Number / ID',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _sendDataAndAwaitResult,
              icon: const Icon(Icons.send),
              label: const Text('Pass Data to Details Screen'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            FilledButton(
              onPressed: () {
                final username = _nameController.text.trim();
                if (username.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter your name first.')),
                  );
                  return;
                }
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Dashboard(username: username),
                  ),
                );
              },
              child: const Text('Continue to dashboard'),
            ),
            const SizedBox(height: 30),
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Returned Result from Second Screen:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _returnedFeedback,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReceiverScreen extends StatefulWidget {
  final StudentData student;

  const ReceiverScreen({super.key, required this.student});

  @override
  State<ReceiverScreen> createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  final TextEditingController _feedbackController = TextEditingController(
    text: 'Approved: Excellent assignment submission!',
  );

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receiver Details Screen'),
        backgroundColor: Colors.teal.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Received Student Information:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Name: ${widget.student.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Roll No: ${widget.student.rollNumber}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Subject: ${widget.student.subject}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: 'Feedback to Return',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.feedback),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Return result back to first screen via Navigator.pop
                Navigator.pop(context, _feedbackController.text.trim());
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Send Feedback & Pop Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Dashboard')),
    body: Center(child: Text('Welcome, $username')),
  );
}
