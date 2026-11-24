class StudentRecord {
  final String id;
  final String name;
  final String course;
  final double grade;

  StudentRecord({
    required this.id,
    required this.name,
    required this.course,
    required this.grade,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'course': course, 'grade': grade};
  }

  factory StudentRecord.fromMap(String id, Map<String, dynamic> map) {
    return StudentRecord(
      id: id,
      name: map['name'] ?? '',
      course: map['course'] ?? '',
      grade: (map['grade'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
