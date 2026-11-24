import 'package:flutter/material.dart';

void main() {
  runApp(const ContainerWidgetApp());
}

class ContainerWidgetApp extends StatelessWidget {
  const ContainerWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Widget Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.cyan, useMaterial3: true),
      home: const ContainerDemoScreen(),
    );
  }
}

class ContainerDemoScreen extends StatelessWidget {
  const ContainerDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container & BoxDecoration'),
        backgroundColor: Colors.cyan.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '1. Linear Gradient & Rounded Corners',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'Gradient Background Container',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 36),

            const Text(
              '2. Border, Margin & Padding Box Model',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                border: Border.all(color: Colors.amber.shade700, width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text(
                    'Margin (outer) = 12.0',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Padding (inner) = 24.0',
                    style: TextStyle(color: Colors.amber.shade900),
                  ),
                  const SizedBox(height: 6),
                  const Text('Solid border with 3.0px width'),
                ],
              ),
            ),
            const Divider(height: 36),

            const Text(
              '3. Circular Container with Elevation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withValues(alpha: 0.4),
                    blurRadius: 15,
                    spreadRadius: 3,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.star, color: Colors.white, size: 50),
            ),
          ],
        ),
      ),
    );
  }
}
