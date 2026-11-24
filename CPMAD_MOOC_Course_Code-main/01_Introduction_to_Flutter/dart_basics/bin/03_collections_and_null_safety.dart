// ignore_for_file: file_names

/// Demonstration of Dart Collections and Null Safety.
void runCollectionsDemo() {
  // Lists (ordered collection)
  List<String> flutterTopics = [
    'Widgets',
    'State Management',
    'Navigation',
    'Networking',
  ];
  flutterTopics.add('Firebase');
  print('Topics Count: ${flutterTopics.length}');
  print('First Topic: ${flutterTopics.first}');

  // A set literal contains unique values.
  Set<int> uniqueIds = {101, 102, 103};
  uniqueIds.add(101);
  print('Unique IDs count (duplicates eliminated): ${uniqueIds.length}');

  // Maps (key-value pairs)
  Map<String, dynamic> courseMeta = {
    'name': 'Mastering Flutter',
    'hours': 3.0,
    'certificate': 'UC-325f5ce8-be0d-4ea2-8456-982c3471064c',
    'verified': true,
  };
  print('Course Meta Info: $courseMeta');

  // Spread operator (...) and Collection If
  bool includeAdvanced = true;
  List<String> fullCurriculum = [
    ...flutterTopics,
    if (includeAdvanced) 'Cloud Firestore & SQLite',
  ];
  print('Curriculum after spread & conditional inclusion: $fullCurriculum');

  // Null Safety
  String? nullableString; // can be null
  print('Nullable string initial value: $nullableString');

  // Null-aware coalescing operator (??)
  String displayName = nullableString ?? 'Default Student';
  print('Display Name: $displayName');

  // Null-aware assignment (??=)
  nullableString ??= 'Assigned Value';
  print('Nullable string after assignment: $nullableString');

  // Null-aware member access (?.)
  print('Length of nullable string: ${nullableString.length}');
}

void main() {
  runCollectionsDemo();
}
