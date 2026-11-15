import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/core/helpers/database_helper.dart';
import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/features/main_layout/cubit/states/cards_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsCubit extends Cubit<CardsStates> {
  final CardsRepository repository = CardsRepository(
    CardsDao(DatabaseHelper.instance),
  );

  int numberOfCards = 0;

  CardsCubit() : super(LoadingCards()) {
    getCards();
  }

  Future<void> getCards() async {
    try {
      emit(LoadingCards());
      var list = await repository.getMyCards();
      numberOfCards = list.length;
      if (list.isNotEmpty) {
        emit(CardLoadedState(list));
      } else {
        emit(NoCardsState());
      }
    } catch (e) {
      numberOfCards = 0;
      emit(FaildCardsState(e.toString()));
    }
  }
}
