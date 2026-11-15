import 'package:business_card/core/helpers/db_helper.dart';
import 'package:business_card/data/models/card_model.dart';

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
