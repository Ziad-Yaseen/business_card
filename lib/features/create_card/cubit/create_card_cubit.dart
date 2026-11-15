import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/core/helpers/database_helper.dart';
import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/features/create_card/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_card_state.dart';

class CreateCardCubit extends Cubit<CreateCardState> {
  CreateCardCubit()
    : super(
        CreateCardState(id: DateTime.now().microsecondsSinceEpoch.toString()),
      );

  final CardsRepository _repository = CardsRepository(
    CardsDao(DatabaseHelper.instance),
  );

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
      await _repository.save(state.toCard());
      emit(state.copyWith(status: CreateStatus.saved));
    } catch (_) {
      emit(state.copyWith(status: CreateStatus.failure));
    }
  }
}