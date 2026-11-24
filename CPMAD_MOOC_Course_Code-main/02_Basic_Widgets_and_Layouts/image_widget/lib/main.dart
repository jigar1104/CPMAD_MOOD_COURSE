import 'package:flutter/material.dart';

void main() {
  runApp(const ImageWidgetApp());
}

class ImageWidgetApp extends StatelessWidget {
  const ImageWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Widgets Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange, useMaterial3: true),
      home: const ImageDemoScreen(),
    );
  }
}

class ImageDemoScreen extends StatelessWidget {
  const ImageDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Images & Avatars'),
        backgroundColor: Colors.deepOrange.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '1. CircleAvatar Widget',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepOrange.shade100,
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.deepOrange,
              ),
            ),
            const Divider(height: 36),

            const Text(
              '2. Rounded Image with ClipRRect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: 180,
                color: Colors.blueGrey.shade100,
                child: Image.network(
                  'https://picsum.photos/400/200',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text('Image placeholder (Network offline/error)'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const Divider(height: 36),

            const Text(
              '3. Icon with FittedBox & Decoration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.amber.shade600, width: 3),
              ),
              child: const Icon(
                Icons.flutter_dash,
                size: 55,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
