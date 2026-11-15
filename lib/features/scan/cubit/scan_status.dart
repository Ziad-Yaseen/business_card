import 'package:business_card/data/models/card_model.dart';

enum ScanStatus { scanning, found, invalid, saving, saved, failure }

class ScanState {
  const ScanState({this.status = ScanStatus.scanning, this.card});

  final ScanStatus status;
  final CardModel? card;

  ScanState copyWith({ScanStatus? status}) =>
      ScanState(status: status ?? this.status, card: card);
}
