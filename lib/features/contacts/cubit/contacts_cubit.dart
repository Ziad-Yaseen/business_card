import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/core/helpers/database_helper.dart';
import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/data/models/saved_contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ContactsStatus { loading, loaded, failure }

class ContactsState {
  const ContactsState({
    this.status = ContactsStatus.loading,
    this.all = const [],
    this.query = '',
  });

  final ContactsStatus status;
  final List<SavedContact> all;
  final String query;

  List<SavedContact> get visible {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((c) {
      final card = c.card;
      final text = [
        card.fullName,
        card.nickName ?? '',
        card.jobTitle,
        card.company ?? '',
      ].join(' ').toLowerCase();
      return text.contains(q);
    }).toList();
  }

  ContactsState copyWith({
    ContactsStatus? status,
    List<SavedContact>? all,
    String? query,
  }) => ContactsState(
    status: status ?? this.status,
    all: all ?? this.all,
    query: query ?? this.query,
  );
}

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(const ContactsState()) {
    load();
  }

  final CardsRepository _repository = CardsRepository(
    CardsDao(DatabaseHelper.instance),
  );

  Future<void> load() async {
    try {
      final list = await _repository.getRecentContacts();
      emit(state.copyWith(status: ContactsStatus.loaded, all: list));
    } catch (_) {
      emit(state.copyWith(status: ContactsStatus.failure));
    }
  }

  void search(String value) => emit(state.copyWith(query: value));
}
