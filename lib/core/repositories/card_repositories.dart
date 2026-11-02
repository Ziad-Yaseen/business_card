import 'dart:math';

import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/data/models/card_model.dart';

class CardsRepository {
  const CardsRepository(this._dao);

  final CardsDao _dao;

  Future<List<CardModel>> getMyCards() => _dao.getAll(mine: true);
  Future<List<CardModel>> getContacts() => _dao.getAll(mine: false);
  Future<CardModel?> getById(String id) => _dao.getById(id);

  Future<void> save(CardModel card) => _dao.save(card);
  Future<void> delete(String id) => _dao.delete(id);

  static String newId() {
    final t = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final r = Random().nextInt(1 << 32).toRadixString(36);
    return '$t$r';
  }
}
