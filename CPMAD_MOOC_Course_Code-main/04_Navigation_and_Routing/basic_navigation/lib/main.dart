import 'package:flutter/material.dart';

void main() => runApp(const BasicNavApp());

class BasicNavApp extends StatelessWidget {
  const BasicNavApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () => Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute(builder: (_) => const DisplayScreen()),
              ),
              child: const Text('Continue to dashboard'),
            ),
            TextButton(
              onPressed: () => Navigator.push<void>(
                context,
                MaterialPageRoute(builder: (_) => const RegistrationScreen()),
              ),
              child: const Text('Open registration'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registration')),
    body: Center(
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Back to login'),
      ),
    ),
  );
}

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Dashboard')),
    body: const Center(child: Text('You replaced the login route.')),
  );
}
