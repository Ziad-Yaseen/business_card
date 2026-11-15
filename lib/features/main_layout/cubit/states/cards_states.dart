import 'package:business_card/data/models/card_model.dart';

class CardsStates {}

class LoadingCards extends CardsStates {}

class FaildCardsState extends CardsStates {
  final String error;
  FaildCardsState(this.error);
}

class NoCardsState extends CardsStates {}

class CardLoadedState extends CardsStates {
  final List<CardModel> cards;
  CardLoadedState(this.cards);
}
