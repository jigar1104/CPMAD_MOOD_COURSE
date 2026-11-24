// ignore_for_file: file_names

// Demonstration of Object-Oriented Programming in Dart.

// Abstract class defining an interface contract
abstract class CourseEntity {
  void displayInfo();
}

// Mixin providing reusable functionality
mixin Certifiable {
  void issueCertificate(String recipientName, String certId) {
    print('>> Certificate Issued to $recipientName [ID: $certId]');
  }
}

// Base class
class Course with Certifiable implements CourseEntity {
  final String title;
  final String instructor;
  final double durationHours;

  // Constructor with initializer
  Course({
    required this.title,
    required this.instructor,
    required this.durationHours,
  });

  @override
  void displayInfo() {
    print('Course: "$title" by $instructor ($durationHours hours)');
  }
}

// Subclass demonstrating inheritance
class FlutterMasteryCourse extends Course {
  final String certificateId;

  FlutterMasteryCourse({
    required super.title,
    required super.instructor,
    required super.durationHours,
    required this.certificateId,
  });

  void verifyStudent(String studentName) {
    displayInfo();
    issueCertificate(studentName, certificateId);
  }
}

void runOopDemo() {
  final flutterCourse = FlutterMasteryCourse(
    title: 'Mastering Flutter: From Basics to Advanced by Building Apps',
    instructor: 'Shamsaagazarzoo Alam',
    durationHours: 3.0,
    certificateId: 'UC-325f5ce8-be0d-4ea2-8456-982c3471064c',
  );

  flutterCourse.verifyStudent('Jigar Mungra');
}

void main() {
  runOopDemo();
}
