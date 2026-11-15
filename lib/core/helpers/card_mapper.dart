import 'dart:convert';

import 'package:business_card/core/helpers/db_helper.dart';
import 'package:business_card/data/models/card_model.dart';

extension CardModelRow on CardModel {
  Map<String, Object?> toRow() => {
    DBHelper.colId: id,
    DBHelper.colMine: mine ? 1 : 0,
    DBHelper.colData: jsonEncode(toJson()),
  };
}

CardModel cardFromRow(Map<String, Object?> row) {
  return CardModel.fromJson(
    jsonDecode(row[DBHelper.colData] as String) as Map<String, dynamic>,
    id: row[DBHelper.colId] as String,
    mine: (row[DBHelper.colMine] as int) == 1,
  );
}
