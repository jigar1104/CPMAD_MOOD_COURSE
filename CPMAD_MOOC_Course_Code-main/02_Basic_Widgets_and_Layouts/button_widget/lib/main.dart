import 'package:flutter/material.dart';

void main() {
  runApp(const ButtonWidgetApp());
}

class ButtonWidgetApp extends StatelessWidget {
  const ButtonWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Button Widgets Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: true),
      home: const ButtonDemoScreen(),
    );
  }
}

class ButtonDemoScreen extends StatefulWidget {
  const ButtonDemoScreen({super.key});

  @override
  State<ButtonDemoScreen> createState() => _ButtonDemoScreenState();
}

class _ButtonDemoScreenState extends State<ButtonDemoScreen> {
  String _lastClicked = 'None';
  int _clickCount = 0;

  void _onButtonPressed(String buttonName) {
    setState(() {
      _lastClicked = buttonName;
      _clickCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Button Widgets'),
        backgroundColor: Colors.teal.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.teal.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Last Pressed: $_lastClicked',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total Clicks: $_clickCount',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 1. ElevatedButton
            ElevatedButton(
              onPressed: () => _onButtonPressed('ElevatedButton'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'ElevatedButton (Filled)',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),

            // 2. ElevatedButton with Icon
            ElevatedButton.icon(
              onPressed: () => _onButtonPressed('ElevatedButton with Icon'),
              icon: const Icon(Icons.send),
              label: const Text('Send Message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 12),

            // 3. OutlinedButton
            OutlinedButton(
              onPressed: () => _onButtonPressed('OutlinedButton'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.teal,
                side: const BorderSide(color: Colors.teal, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'OutlinedButton (Bordered)',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),

            // 4. TextButton
            TextButton(
              onPressed: () => _onButtonPressed('TextButton'),
              style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
              child: const Text(
                'TextButton (Flat / Link style)',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),

            // 5. Disabled Button demonstration
            const ElevatedButton(
              onPressed: null, // null disables the button
              child: Text('Disabled ElevatedButton (onPressed: null)'),
            ),
            const SizedBox(height: 20),

            // 6. Icon Buttons in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.blue),
                  onPressed: () => _onButtonPressed('Like (IconButton)'),
                  tooltip: 'Like',
                ),
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => _onButtonPressed('Favorite (IconButton)'),
                  tooltip: 'Favorite',
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.green),
                  onPressed: () => _onButtonPressed('Share (IconButton)'),
                  tooltip: 'Share',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onButtonPressed('FloatingActionButton'),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
