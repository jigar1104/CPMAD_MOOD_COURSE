import 'package:get/get.dart';

class TaskItem {
  final String title;
  final RxBool isCompleted;

  TaskItem({required this.title, bool completed = false})
    : isCompleted = completed.obs;
}

class TaskController extends GetxController {
  // Observable list of tasks
  var tasks = <TaskItem>[
    TaskItem(title: 'Review Flutter Widgets', completed: true),
    TaskItem(title: 'Master GetX Controllers', completed: false),
    TaskItem(title: 'Implement SQLite & REST APIs', completed: false),
  ].obs;

  void addTask(String title) {
    if (title.trim().isNotEmpty) {
      tasks.add(TaskItem(title: title.trim()));
      Get.snackbar(
        'Task Added',
        'Task "$title" was added to the list.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void removeTask(int index) {
    final removed = tasks[index].title;
    tasks.removeAt(index);
    Get.snackbar(
      'Task Removed',
      'Task "$removed" deleted.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void toggleTask(int index) {
    tasks[index].isCompleted.toggle();
  }
}
