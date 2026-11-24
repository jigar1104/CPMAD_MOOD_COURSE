import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite_database/database_helper.dart';
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
      final db = DatabaseHelper(databasePath: '${folder.path}/course_test.db');
      addTearDown(() async {
        await db.close();
        await folder.delete(recursive: true);
      });

      final id = await db.insertUser(
        UserItem(name: 'Taylor', email: 'taylor@example.test'),
      );
      await db.close();
      expect((await db.getAllUsers()).single.id, id);
      expect(
        await db.updateUser(
          UserItem(id: id, name: 'Taylor', email: 'new@example.test'),
        ),
        1,
      );
      expect((await db.getAllUsers()).single.email, 'new@example.test');
      expect(await db.deleteUser(id), 1);
      expect(await db.getAllUsers(), isEmpty);
    },
  );
}
