import 'package:business_card/data/models/card_model.dart';

class SavedContact {
  const SavedContact({required this.card, required this.savedAt});

  final CardModel card;
  final DateTime savedAt;
}
