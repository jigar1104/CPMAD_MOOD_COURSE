class TodoTask {
  final int id;
  String title;
  bool isCompleted;

  TodoTask({required this.id, required this.title, required this.isCompleted});

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return TodoTask(
      id: json['id'] as int,
      title: json['todo'] ?? json['title'] ?? 'Task',
      isCompleted: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'completed': isCompleted,
  };
}
