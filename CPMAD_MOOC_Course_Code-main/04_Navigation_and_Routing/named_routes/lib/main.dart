import 'package:flutter/material.dart';

void main() => runApp(const NamedRoutesApp());

class NamedRoutesApp extends StatelessWidget {
  const NamedRoutesApp({super.key});

  static const splash = '/';
  static const login = '/login';
  static const dashboard = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: splash,
      onGenerateRoute: (settings) {
        final username = settings.arguments;
        final Widget page = switch (settings.name) {
          splash => const SplashScreen(),
          login => const LoginScreen(),
          dashboard when username is String => Dashboard(username: username),
          _ => const Scaffold(body: Center(child: Text('Route unavailable'))),
        };
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => page,
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Named Routes')),
    body: Center(
      child: FilledButton(
        onPressed: () => Navigator.pushNamed(context, NamedRoutesApp.login),
        child: const Text('Open login'),
      ),
    ),
  );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Center(
      child: FilledButton(
        onPressed: () => Navigator.pushReplacementNamed(
          context,
          NamedRoutesApp.dashboard,
          arguments: 'Flutter learner',
        ),
        child: const Text('Open dashboard'),
      ),
    ),
  );
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
