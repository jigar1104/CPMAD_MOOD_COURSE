import 'package:flutter/material.dart';

void main() {
  runApp(const TextWidgetApp());
}

class TextWidgetApp extends StatelessWidget {
  const TextWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Widget Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const TextDemoScreen(),
    );
  }
}

class TextDemoScreen extends StatelessWidget {
  const TextDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text & RichText Widgets'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Basic Text Widget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Simple plain text without explicit styles.'),
            const Divider(height: 32),

            const Text(
              '2. Styled Text with TextStyle',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Bold, Colored & Underlined Text',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.indigo.shade800,
                letterSpacing: 1.5,
                decoration: TextDecoration.underline,
                decorationColor: Colors.deepOrange,
                decorationThickness: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Text with Shadow Effect',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
                shadows: const [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const Divider(height: 32),

            const Text(
              '3. RichText with Multiple TextSpans',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                children: [
                  const TextSpan(
                    text: 'Flutter is an open-source framework by ',
                  ),
                  TextSpan(
                    text: 'Google',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                  const TextSpan(text: ' to build multi-platform apps using '),
                  TextSpan(
                    text: 'Dart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                      backgroundColor: Colors.blue.shade50,
                    ),
                  ),
                  const TextSpan(text: ' from a single codebase!'),
                ],
              ),
            ),
            const Divider(height: 32),

            const Text(
              '4. Text Overflow Handling',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade200,
              width: 250,
              child: const Text(
                'This is a long sentence intended to test how Flutter clips or adds an ellipsis to overflowing text.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
