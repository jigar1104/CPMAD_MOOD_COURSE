import 'package:flutter/material.dart';

void main() {
  runApp(const RowColumnApp());
}

class RowColumnApp extends StatelessWidget {
  const RowColumnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row & Column Layouts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
      home: const RowColumnScreen(),
    );
  }
}

class RowColumnScreen extends StatelessWidget {
  const RowColumnScreen({super.key});

  Widget _buildBox(
    String text,
    Color color, {
    double width = 60,
    double height = 60,
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row, Column & Flex Layouts'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Row: SpaceBetween Alignment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBox('A', Colors.red),
                  _buildBox('B', Colors.green),
                  _buildBox('C', Colors.blue),
                ],
              ),
            ),
            const Divider(height: 32),

            const Text(
              '2. Row with Expanded & Spacer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  _buildBox('Fix 60', Colors.purple),
                  const Spacer(),
                  Expanded(
                    child: Container(
                      height: 60,
                      color: Colors.orange,
                      alignment: Alignment.center,
                      child: const Text(
                        'Expanded Widget (Fills Remaining Space)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 32),

            const Text(
              '3. Column: Centered Alignment with Spacing',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildBox('Top', Colors.teal, width: 120, height: 40),
                  const SizedBox(height: 10),
                  _buildBox('Middle', Colors.cyan, width: 120, height: 40),
                  const SizedBox(height: 10),
                  _buildBox(
                    'Bottom',
                    Colors.deepOrange,
                    width: 120,
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
