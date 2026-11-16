import 'package:business_card/core/helpers/db_helper.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/data/models/saved_contact.dart';

import 'card_mapper.dart';
import 'database_helper.dart';

class CardsDao {
  const CardsDao(this._helper);

  final DatabaseHelper _helper;

  static const _table = DBHelper.cardsTable;

  Future<List<CardModel>> getAll({required bool mine}) async {
    final rows = await _helper.query(
      _table,
      where: '${DBHelper.colMine} = ?',
      whereArgs: [mine ? 1 : 0],
      orderBy: '${DBHelper.colCreatedAt} ASC',
    );
    return rows.map(cardFromRow).toList();
  }

  Future<List<SavedContact>> getRecentContacts() async {
    final rows = await _helper.query(
      _table,
      where: '${DBHelper.colMine} = ?',
      whereArgs: [0],
      orderBy: '${DBHelper.colCreatedAt} DESC',
    );
    return rows.map(_withDate).toList();
  }

  Future<List<SavedContact>> getAllWithDates() async {
    final result = <SavedContact>[];
    for (final mine in [1, 0]) {
      final rows = await _helper.query(
        _table,
        where: '${DBHelper.colMine} = ?',
        whereArgs: [mine],
        orderBy: '${DBHelper.colCreatedAt} ASC',
      );
      result.addAll(rows.map(_withDate));
    }
    return result;
  }

  Future<void> restoreAll(List<SavedContact> items) async {
    for (final item in items) {
      await _helper.upsert(
        _table,
        item.card.toRow(),
        keyColumn: DBHelper.colId,
        insertOnly: {
          DBHelper.colCreatedAt: item.savedAt.millisecondsSinceEpoch,
        },
      );
    }
  }

  SavedContact _withDate(Map<String, Object?> row) {
    final millis = (row[DBHelper.colCreatedAt] as int?) ?? 0;
    return SavedContact(
      card: cardFromRow(row),
      savedAt: DateTime.fromMillisecondsSinceEpoch(millis),
    );
  }

  Future<CardModel?> getById(String id) async {
    final rows = await _helper.query(
      _table,
      where: '${DBHelper.colId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : cardFromRow(rows.first);
  }

  Future<void> save(CardModel card) => _helper.upsert(
    _table,
    card.toRow(),
    keyColumn: DBHelper.colId,
    insertOnly: {DBHelper.colCreatedAt: DateTime.now().millisecondsSinceEpoch},
  );

  Future<void> delete(String id) =>
      _helper.delete(_table, where: '${DBHelper.colId} = ?', whereArgs: [id]);
}
