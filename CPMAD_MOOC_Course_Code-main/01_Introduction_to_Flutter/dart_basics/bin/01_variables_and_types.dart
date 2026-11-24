// ignore_for_file: file_names

/// Demonstration of Dart variables, data types, and constants.
void runVariablesDemo() {
  // Numeric types
  int age = 22;
  double height = 5.9;
  num rating = 4.8; // num can hold either int or double

  // Strings and String interpolation
  String studentName = 'Jigar Mungra';
  String greeting = 'Hello, $studentName! Age: $age, Height: $height ft';

  // Boolean
  bool isEnrolled = true;

  // Type inference (var) vs Explicit typing
  var courseTitle = 'Mastering Flutter';

  // Immutability: final vs const
  // final: runtime constant (assigned once)
  final DateTime accessTime = DateTime.now();

  // const: compile-time constant
  const double pi = 3.14159265359;

  print('Student: $studentName');
  print('Course: $courseTitle');
  print('Rating: $rating / 5.0 (Is Enrolled: $isEnrolled)');
  print('Greeting Message: $greeting');
  print('Access Timestamp (final): $accessTime');
  print('Mathematical Constant PI (const): $pi');
}

void main() {
  runVariablesDemo();
}
