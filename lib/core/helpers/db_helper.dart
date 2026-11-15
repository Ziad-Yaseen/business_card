import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const fileName = 'cards.db';

  static const cardsTable = 'cards';
  static const colId = 'id';
  static const colMine = 'mine';
  static const colCreatedAt = 'created_at';
  static const colData = 'data';

  static Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cardsTable (
        $colId        TEXT    PRIMARY KEY,
        $colMine      INTEGER NOT NULL,
        $colCreatedAt INTEGER NOT NULL,
        $colData      TEXT    NOT NULL
      )
    ''');
    await db.execute(
      'CREATE INDEX idx_cards_mine ON $cardsTable ($colMine, $colCreatedAt)',
    );
  }

  static const Map<int, List<String>> _migrations = {};

  static Future<void> onUpgrade(Database db, int oldV, int newV) async {
    for (var v = oldV + 1; v <= newV; v++) {
      for (final sql in _migrations[v] ?? const <String>[]) {
        await db.execute(sql);
      }
    }
  }
}
