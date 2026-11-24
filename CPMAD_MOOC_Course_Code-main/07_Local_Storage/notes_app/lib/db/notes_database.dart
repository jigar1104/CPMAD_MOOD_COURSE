import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase();
  Database? _database;
  final String? databasePath;

  NotesDatabase({this.databasePath});

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final explicitPath = databasePath;
    if (explicitPath != null) return _open(explicitPath);
    final dbPath = await getDatabasesPath();
    final previousPath = join(dbPath, filePath);
    // Keep existing notes at their original location.
    final path = await databaseExists(previousPath)
        ? previousPath
        : join((await getApplicationDocumentsDirectory()).path, filePath);

    return _open(path);
  }

  Future<Database> _open(String path) {
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        priority TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }

  Future<Note> createNote(Note note) async {
    final db = await database;
    final id = await db.insert('notes', note.toMap());
    return note.copyWith(id: id);
  }

  Future<List<Note>> readAllNotes() async {
    final db = await database;
    final result = await db.query('notes', orderBy: 'id DESC');
    return result.map((json) => Note.fromMap(json)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
