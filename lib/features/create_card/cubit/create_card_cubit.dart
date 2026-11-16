import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/features/create_card/cubit/profile_cubit.dart';
import 'package:business_card/features/main_layout/cubit/cards_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_card_state.dart';

class CreateCardCubit extends Cubit<CreateCardState> {
  CreateCardCubit({required CardsCubit cards, CardModel? card})
    : _cards = cards,
      super(
        card == null
            ? CreateCardState(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
              )
            : CreateCardState.fromCard(card),
      );

  final CardsCubit _cards;

  void colorChanged(int i) => emit(state.copyWith(colorIndex: i));
  void patternChanged(CardPattern p) => emit(state.copyWith(pattern: p));

  void firstNameChanged(String v) => emit(state.copyWith(firstName: v));
  void lastNameChanged(String v) => emit(state.copyWith(lastName: v));
  void middleNameChanged(String v) => emit(state.copyWith(middleName: v));
  void nickNameChanged(String v) => emit(state.copyWith(nickName: v));
  void jobTitleChanged(String v) => emit(state.copyWith(jobTitle: v));
  void companyChanged(String v) => emit(state.copyWith(company: v));
  void emailsChanged(List<String> v) => emit(state.copyWith(emails: v));
  void phonesChanged(List<String> v) => emit(state.copyWith(phones: v));

  void linkedInChanged(String v) => emit(state.copyWith(linkedIn: v));
  void githubChanged(String v) => emit(state.copyWith(github: v));
  void portfolioChanged(String v) => emit(state.copyWith(portfolio: v));
  void profilesChanged(Map<ProfileType, String> v) =>
      emit(state.copyWith(profiles: v));
  void moreChanged(List<String> v) => emit(state.copyWith(more: v));

  Future<void> save() async {
    if (state.status == CreateStatus.saving) return;

    if (!state.isValid) {
      emit(state.copyWith(status: CreateStatus.invalid));
      return;
    }

    emit(state.copyWith(status: CreateStatus.saving));
    try {
      await _cards.save(state.toCard());
      emit(state.copyWith(status: CreateStatus.saved));
    } catch (_) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }
}
