import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SqliteDemoApp());
}

class SqliteDemoApp extends StatelessWidget {
  const SqliteDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Database Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  List<UserItem> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _refreshUsers() async {
    setState(() => _isLoading = true);
    final data = await DatabaseHelper.instance.getAllUsers();
    if (!mounted) return;
    setState(() {
      _users = data;
      _isLoading = false;
    });
  }

  void _showAddDialog([UserItem? user]) {
    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(user == null ? 'Add SQLite user' : 'Edit SQLite user'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    final name = _nameController.text.trim();
                    final email = _emailController.text.trim();
                    if (name.isEmpty || email.isEmpty) return;
                    Navigator.pop(ctx);
                    final edited = UserItem(
                      id: user?.id,
                      name: name,
                      email: email,
                    );
                    if (user == null) {
                      await DatabaseHelper.instance.insertUser(edited);
                    } else {
                      await DatabaseHelper.instance.updateUser(edited);
                    }
                    if (mounted) await _refreshUsers();
                  },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    if (mounted) await _refreshUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Database Operations'),
        backgroundColor: Colors.brown.shade100,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
          ? const Center(child: Text('No users in database. Tap + to add one!'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _users.length,
              itemBuilder: (ctx, i) {
                final u = _users[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${u.id}')),
                    title: Text(
                      u.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(u.email),
                    onTap: () => _showAddDialog(u),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteUser(u.id!),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
