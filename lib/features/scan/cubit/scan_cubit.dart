import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/core/helpers/database_helper.dart';
import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/features/scan/cubit/scan_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit(read) : super(const ScanState());

  final CardsRepository _repository = CardsRepository(
    CardsDao(DatabaseHelper.instance),
  );

  void onDetect(List<String?> values) {
    if (state.status != ScanStatus.scanning) return;

    var sawAnything = false;
    for (final raw in values) {
      if (raw == null) continue;
      sawAnything = true;
      final CardModel? card = CardModel.decode(raw);
      if (card != null) {
        emit(ScanState(status: ScanStatus.found, card: card));
        return;
      }
    }
    if (sawAnything) emit(const ScanState(status: ScanStatus.invalid));
  }

  void scanAgain() => emit(const ScanState());

  Future<void> save() async {
    final card = state.card;
    final status = state.status;
    if (card == null) return;
    if (status != ScanStatus.found && status != ScanStatus.failure) return;

    emit(state.copyWith(status: ScanStatus.saving));
    try {
      await _repository.save(card);
      emit(state.copyWith(status: ScanStatus.saved));
    } catch (_) {
      emit(state.copyWith(status: ScanStatus.failure));
    }
  }
}
