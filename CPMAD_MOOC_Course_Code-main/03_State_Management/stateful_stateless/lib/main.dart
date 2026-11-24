import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetTypesApp());
}

class WidgetTypesApp extends StatelessWidget {
  const WidgetTypesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateless vs Stateful',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const WidgetComparisonScreen(),
    );
  }
}

class WidgetComparisonScreen extends StatelessWidget {
  const WidgetComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widgets'),
        backgroundColor: Colors.green.shade100,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Stateless Widget Demo
            StatelessHeaderWidget(
              title: 'Stateless Widget Demo',
              description:
                  'Stateless widgets are immutable. Once built, their configuration and visual appearance cannot change dynamically based on internal user actions.',
            ),
            SizedBox(height: 24),

            // 2. Stateful Widget Demo
            StatefulToggleWidget(),
          ],
        ),
      ),
    );
  }
}

/// Example of an immutable StatelessWidget
class StatelessHeaderWidget extends StatelessWidget {
  final String title;
  final String description;

  const StatelessHeaderWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lock, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example of an interactive StatefulWidget with mutable State
class StatefulToggleWidget extends StatefulWidget {
  const StatefulToggleWidget({super.key});

  @override
  State<StatefulToggleWidget> createState() => _StatefulToggleWidgetState();
}

class _StatefulToggleWidgetState extends State<StatefulToggleWidget> {
  bool _isBookmarked = false;
  int _likesCount = 42;

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  void _incrementLike() {
    setState(() {
      _likesCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.refresh, color: Colors.green),
                const SizedBox(width: 8),
                const Text(
                  'Stateful Widget Demo (Mutable)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'A StatefulWidget creates a persistent State object that rebuilds when setState() is invoked.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Bookmark toggle
                ElevatedButton.icon(
                  onPressed: _toggleBookmark,
                  icon: Icon(
                    _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: _isBookmarked ? Colors.amber.shade900 : Colors.grey,
                  ),
                  label: Text(_isBookmarked ? 'Bookmarked' : 'Add Bookmark'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isBookmarked
                        ? Colors.amber.shade100
                        : Colors.white,
                  ),
                ),
                // Like counter
                ElevatedButton.icon(
                  onPressed: _incrementLike,
                  icon: const Icon(Icons.thumb_up, color: Colors.green),
                  label: Text('Likes: $_likesCount'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
