import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'todo_api.dart';
import 'todo_task.dart';

void main() => runApp(const TodoApiApp());

class TodoApiApp extends StatelessWidget {
  const TodoApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoListScreen());
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _client = http.Client();
  late final _api = TodoApi(_client);
  List<TodoTask> _todos = [];
  bool _busy = false;
  int _nextSessionId = -1;
  String? _message;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  Future<void> _perform(Future<void> Function() request) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      await request();
    } catch (error) {
      if (mounted) _message = 'Request failed: $error';
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _load() => _perform(() async {
    final items = await _api.fetch();
    if (mounted) _todos = items;
  });

  Future<void> _add() async {
    final title = await showDialog<String>(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
    if (!mounted || title == null) return;

    await _perform(() async {
      final saved = await _api.create(title);
      if (!mounted) return;
      // DummyJSON simulates POST. The returned record has no server resource.
      _todos.insert(
        0,
        TodoTask(
          id: _nextSessionId--,
          title: saved.title,
          isCompleted: saved.isCompleted,
        ),
      );
      _message = 'POST accepted. Added for this session.';
    });
  }

  Future<void> _toggle(TodoTask item, bool completed) => _perform(() async {
    final updated = item.id < 0 ? null : await _api.update(item.id, completed);
    if (!mounted) return;
    item.isCompleted = updated?.isCompleted ?? completed;
    _message = updated == null ? 'Session item updated.' : 'PUT accepted.';
  });

  Future<void> _remove(TodoTask item) => _perform(() async {
    if (item.id >= 0) await _api.delete(item.id);
    if (!mounted) return;
    _todos.remove(item);
    _message = item.id < 0 ? 'Session item removed.' : 'DELETE accepted.';
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo REST API'),
        actions: [
          IconButton(
            onPressed: _busy ? null : _load,
            tooltip: 'Reload todos',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_busy) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              _message ?? 'DummyJSON writes are simulated and reset on reload.',
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final item in _todos)
                  ListTile(
                    key: ValueKey(item.id),
                    leading: Checkbox(
                      value: item.isCompleted,
                      onChanged: _busy
                          ? null
                          : (value) => _toggle(item, value!),
                    ),
                    title: Text(item.title),
                    subtitle: Text(
                      item.id < 0 ? 'Session todo' : 'API todo ${item.id}',
                    ),
                    trailing: IconButton(
                      onPressed: _busy ? null : () => _remove(item),
                      tooltip: 'Delete todo',
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _busy ? null : _add,
        tooltip: 'Add todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add todo'),
      content: Form(
        key: _form,
        child: TextFormField(
          controller: _title,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Task title'),
          validator: (value) =>
              value == null || value.trim().isEmpty ? 'Enter a title' : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_form.currentState!.validate()) {
              Navigator.pop(context, _title.text.trim());
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
