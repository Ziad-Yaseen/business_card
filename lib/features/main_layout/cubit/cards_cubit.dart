import 'package:business_card/core/helpers/backup_service.dart';
import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/core/helpers/database_helper.dart';
import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/data/models/saved_contact.dart';
import 'package:business_card/features/main_layout/cubit/states/cards_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsCubit extends Cubit<CardsStates> {
  final CardsRepository repository = CardsRepository(
    CardsDao(DatabaseHelper.instance),
  );

  late final BackupService _backup = BackupService(repository);

  int numberOfCards = 0;

  List<SavedContact> contacts = const [];

  CardsCubit() : super(LoadingCards()) {
    getCards();
  }

  Future<void> getCards() async {
    try {
      if (state is! CardLoadedState && state is! NoCardsState) {
        emit(LoadingCards());
      }
      final mine = await repository.getMyCards();
      contacts = await repository.getRecentContacts();
      numberOfCards = mine.length;
      emit(mine.isEmpty ? NoCardsState() : CardLoadedState(mine));
    } catch (e) {
      numberOfCards = 0;
      emit(FaildCardsState(e.toString()));
    }
  }

  Future<void> save(CardModel card) async {
    await repository.save(card);
    await getCards();
  }

  Future<void> delete(String id) async {
    await repository.delete(id);
    await getCards();
  }

  Future<void> duplicate(CardModel card) =>
      save(card.copyWith(id: CardsRepository.newId()));

  Future<CardModel?> byId(String id) => repository.getById(id);

  Future<BackupResult> backup() => _backup.backup();

  Future<BackupResult> restore() async {
    final result = await _backup.restore();
    if (result.status == BackupStatus.ok) await getCards();
    return result;
  }
}
