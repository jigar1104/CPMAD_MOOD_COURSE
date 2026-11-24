class Note {
  final int? id;
  final String title;
  final String description;
  final String priority; // High, Medium, Low
  final String createdAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'created_at': createdAt,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      priority: map['priority'] as String,
      createdAt: map['created_at'] as String,
    );
  }

  Note copyWith({
    int? id,
    String? title,
    String? description,
    String? priority,
    String? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
