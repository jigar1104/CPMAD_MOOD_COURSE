import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/counter_controller.dart';
import '../controllers/task_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  // Inject controllers into GetX dependency registry
  final CounterController counterController = Get.put(CounterController());
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = counterController.isDarkTheme.value;
      return Scaffold(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('GetX Reactive Management'),
          backgroundColor: isDark ? Colors.black87 : Colors.deepPurple.shade100,
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: counterController.toggleTheme,
              tooltip: 'Toggle Theme',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Reactive Counter Card
              Card(
                color: isDark ? Colors.grey.shade800 : Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Reactive State (Obx):',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Fine-grained Obx rebuild
                      Obx(
                        () => Text(
                          '${counterController.count.value}',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.tealAccent
                                : Colors.deepPurple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton.filled(
                            onPressed: counterController.decrement,
                            icon: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 12),
                          IconButton.filled(
                            onPressed: counterController.increment,
                            icon: const Icon(Icons.add),
                          ),
                          const SizedBox(width: 12),
                          IconButton.outlined(
                            onPressed: counterController.reset,
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Reactive Task List
              Card(
                color: isDark ? Colors.grey.shade800 : Colors.white,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reactive Task List:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter new task...',
                                hintStyle: TextStyle(
                                  color: isDark ? Colors.white54 : Colors.grey,
                                ),
                                border: const OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              taskController.addTask(textController.text);
                              textController.clear();
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: taskController.tasks.length,
                          separatorBuilder: (ctx, i) =>
                              const Divider(height: 1),
                          itemBuilder: (ctx, index) {
                            final item = taskController.tasks[index];
                            return Obx(
                              () => ListTile(
                                dense: true,
                                leading: Checkbox(
                                  value: item.isCompleted.value,
                                  onChanged: (val) =>
                                      taskController.toggleTask(index),
                                ),
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    decoration: item.isCompleted.value
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      taskController.removeTask(index),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
