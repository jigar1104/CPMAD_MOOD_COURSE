import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserItem {
  final int? id;
  final String name;
  final String email;

  UserItem({this.id, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  factory UserItem.fromMap(Map<String, dynamic> map) {
    return UserItem(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper();
  Database? _database;
  final String? databasePath;

  DatabaseHelper({this.databasePath});

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users_demo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final explicitPath = databasePath;
    if (explicitPath != null) return _open(explicitPath);
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return _open(path);
  }

  Future<Database> _open(String path) {
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUser(UserItem user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<List<UserItem>> getAllUsers() async {
    final db = await database;
    final result = await db.query('users', orderBy: 'id DESC');
    return result.map((json) => UserItem.fromMap(json)).toList();
  }

  Future<int> updateUser(UserItem user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
