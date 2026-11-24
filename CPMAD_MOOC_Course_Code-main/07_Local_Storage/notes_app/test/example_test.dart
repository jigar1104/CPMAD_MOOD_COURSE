import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/db/notes_database.dart';
import 'package:notes_app/models/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test(
    'persists records across reopen and supports update and delete',
    () async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      final folder = await Directory.systemTemp.createTemp(
        'course_sqlite_test_',
      );
      final db = NotesDatabase(databasePath: '${folder.path}/course_test.db');
      addTearDown(() async {
        await db.close();
        await folder.delete(recursive: true);
      });

      final note = await db.createNote(
        Note(
          title: 'Flutter notes',
          description: 'First draft',
          priority: 'Low',
          createdAt: '2026-11-23',
        ),
      );
      await db.close();
      expect((await db.readAllNotes()).single.id, note.id);
      expect(await db.updateNote(note.copyWith(description: 'Updated')), 1);
      expect((await db.readAllNotes()).single.description, 'Updated');
      expect(await db.deleteNote(note.id!), 1);
      expect(await db.readAllNotes(), isEmpty);
    },
  );
}
