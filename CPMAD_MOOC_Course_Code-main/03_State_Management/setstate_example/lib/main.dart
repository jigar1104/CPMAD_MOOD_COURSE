import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const SetStateApp());
}

class SetStateApp extends StatelessWidget {
  const SetStateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'setState Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const CounterStateScreen(),
    );
  }
}

class CounterStateScreen extends StatefulWidget {
  const CounterStateScreen({super.key});

  @override
  State<CounterStateScreen> createState() => _CounterStateScreenState();
}

class _CounterStateScreenState extends State<CounterStateScreen> {
  final _random = Random();
  int _counter = 0;
  Color _cardColor = Colors.deepPurple.shade50;
  bool _isSwitchOn = false;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  void _toggleThemeColor() {
    setState(() {
      _cardColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = _cardColor.computeLuminance() > 0.179
        ? Colors.black
        : Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState State Management'),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: _cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Current Counter Value:',
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_counter',
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: _decrement,
                          icon: const Icon(Icons.remove),
                          tooltip: 'Decrement',
                        ),
                        const SizedBox(width: 16),
                        IconButton.filled(
                          onPressed: _increment,
                          icon: const Icon(Icons.add),
                          tooltip: 'Increment',
                        ),
                        const SizedBox(width: 16),
                        IconButton.outlined(
                          onPressed: _reset,
                          icon: const Icon(Icons.restart_alt),
                          tooltip: 'Reset',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Color toggle with setState
              OutlinedButton.icon(
                onPressed: _toggleThemeColor,
                icon: const Icon(Icons.palette),
                label: const Text('Randomize Card Color'),
              ),
              const SizedBox(height: 16),

              // Switch control with setState
              SwitchListTile(
                title: const Text('Enable Notifications Flag'),
                subtitle: Text(
                  'Status: ${_isSwitchOn ? "Active" : "Disabled"}',
                ),
                value: _isSwitchOn,
                onChanged: (bool value) {
                  setState(() {
                    _isSwitchOn = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
