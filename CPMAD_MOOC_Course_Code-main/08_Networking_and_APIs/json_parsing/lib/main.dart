import 'dart:convert';
import 'package:flutter/material.dart';
import 'student_profile.dart';

void main() {
  runApp(const JsonParsingApp());
}

class JsonParsingApp extends StatelessWidget {
  const JsonParsingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON Parsing Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const JsonDemoScreen(),
    );
  }
}

class JsonDemoScreen extends StatefulWidget {
  const JsonDemoScreen({super.key});

  @override
  State<JsonDemoScreen> createState() => _JsonDemoScreenState();
}

class _JsonDemoScreenState extends State<JsonDemoScreen> {
  final String _sampleJsonPayload = '''
  [
    {
      "id": 1,
      "name": "Jigar Mungra",
      "email": "mungrajigar7@gmail.com",
      "address": {
        "street": "College Road",
        "city": "Mumbai",
        "zipcode": "400001",
        "geo": {
          "lat": "19.0760",
          "lng": "72.8777"
        }
      }
    },
    {
      "id": 2,
      "name": "Shamsaagazarzoo Alam",
      "email": "shamsaagazarzoo@udemy.course",
      "address": {
        "street": "Instructor Avenue",
        "city": "San Francisco",
        "zipcode": "94105",
        "geo": {
          "lat": "37.7749",
          "lng": "-122.4194"
        }
      }
    }
  ]
  ''';

  List<StudentProfile> _parsedProfiles = [];
  String _serializationOutput = '';

  @override
  void initState() {
    super.initState();
    _parseJson();
  }

  void _parseJson() {
    final List<dynamic> decodedList = jsonDecode(_sampleJsonPayload);
    setState(() {
      _parsedProfiles = decodedList
          .map((item) => StudentProfile.fromJson(item))
          .toList();
    });
  }

  void _serializeBackToJson() {
    final List<Map<String, dynamic>> mapList = _parsedProfiles
        .map((user) => user.toJson())
        .toList();
    final encoder = const JsonEncoder.withIndent('  ');
    setState(() {
      _serializationOutput = encoder.convert(mapList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested JSON Parsing & Mapping'),
        backgroundColor: Colors.teal.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Deserialized Strongly-Typed Dart Objects:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _parsedProfiles.length,
              itemBuilder: (ctx, i) {
                final u = _parsedProfiles[i];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${u.id}')),
                    title: Text(
                      u.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${u.email}\n'
                      'Address: ${u.location.street}, ${u.location.city} (${u.location.postalCode})\n'
                      'Coordinates: [Lat: ${u.location.coordinates.latitude}, Lng: ${u.location.coordinates.longitude}]',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _serializeBackToJson,
              icon: const Icon(Icons.code),
              label: const Text('Test Serialization Back to JSON'),
            ),
            if (_serializationOutput.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Serialized Output (jsonEncode):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _serializationOutput,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.greenAccent,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
