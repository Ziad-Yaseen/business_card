import 'package:business_card/core/helpers/db_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Future<Database>? _opening;

  Future<Database> get database => _opening ??= _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), DBHelper.fileName);
    return openDatabase(
      path,
      version: 1,
      onCreate: DBHelper.onCreate,
      onUpgrade: DBHelper.onUpgrade,
    );
  }

  Future<List<Map<String, Object?>>> query(
    String table, {
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final db = await database;
    return db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  Future<int> insert(String table, Map<String, Object?> values) async {
    final db = await database;
    return db.insert(table, values);
  }

  Future<int> update(
    String table,
    Map<String, Object?> values, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await database;
    return db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(
    String table, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await database;
    return db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> upsert(
    String table,
    Map<String, Object?> values, {
    required String keyColumn,
    Map<String, Object?> insertOnly = const {},
  }) async {
    final db = await database;
    await db.transaction((txn) async {
      final updated = await txn.update(
        table,
        values,
        where: '$keyColumn = ?',
        whereArgs: [values[keyColumn]],
      );
      if (updated == 0) {
        await txn.insert(table, {...values, ...insertOnly});
      }
    });
  }

  Future<void> close() async {
    final db = await _opening;
    await db?.close();
    _opening = null;
  }
}
