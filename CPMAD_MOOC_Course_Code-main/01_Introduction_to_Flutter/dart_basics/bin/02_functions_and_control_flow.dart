// ignore_for_file: file_names

// Demonstration of Dart functions, parameters, and control flow.

// Positional parameters
int addNumbers(int a, int b) {
  return a + b;
}

// Arrow syntax function
int multiply(int a, int b) => a * b;

// Named parameters with required and optional default values
String formatUserProfile({
  required String name,
  String role = 'Student',
  int? semester,
}) {
  return 'User: $name | Role: $role | Semester: ${semester ?? "N/A"}';
}

void runFunctionsDemo() {
  print('Add: 10 + 25 = ${addNumbers(10, 25)}');
  print('Multiply: 6 * 7 = ${multiply(6, 7)}');
  print(formatUserProfile(name: 'Jigar', semester: 5));
  print(formatUserProfile(name: 'Shamsaagazarzoo', role: 'Instructor'));

  // Control Flow: if / else if / else
  int score = 88;
  String grade;
  if (score >= 90) {
    grade = 'A+';
  } else if (score >= 80) {
    grade = 'A';
  } else {
    grade = 'B';
  }
  print('Score: $score => Grade: $grade');

  // Switch-case with Dart 3 pattern matching
  final status = 'completed';
  switch (status) {
    case 'in_progress':
      print('Status: Working on the project');
      break;
    case 'completed':
      print('Status: Course modules fully finished');
      break;
    default:
      print('Status: Unknown state');
  }

  // Loops: for, for-in, while
  print('Counting loop:');
  for (int i = 1; i <= 3; i++) {
    print('  Iteration #$i');
  }
}

void main() {
  runFunctionsDemo();
}
