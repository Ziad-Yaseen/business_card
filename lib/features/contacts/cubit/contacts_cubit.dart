import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/core/helpers/database_helper.dart';
import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsLoading()) {
    loadContacts();
  }

  final CardsRepository repository = CardsRepository(
    CardsDao(DatabaseHelper.instance),
  );

  String _currentQuery = '';

  Future<void> loadContacts() async {
    try {
      emit(ContactsLoading());
      final cards = await repository.getAllCards();
      _emitFiltered(cards, _currentQuery);
    } catch (e) {
      emit(ContactsError(e.toString()));
    }
  }

  void search(String query) {
    _currentQuery = query.trim().toLowerCase();
    if (state is ContactsLoaded) {
      final current = (state as ContactsLoaded).allContacts;
      _emitFiltered(current, _currentQuery);
    }
  }

  void clearSearch() {
    search('');
  }

  void _emitFiltered(List<CardModel> all, String query) {
    if (query.isEmpty) {
      emit(
        ContactsLoaded(
          allContacts: all,
          filteredContacts: all,
          searchQuery: '',
        ),
      );
    } else {
      final filtered = all.where((c) {
        final name = c.displayName.toLowerCase();
        final role = c.jobTitle.toLowerCase();
        final comp = (c.company ?? '').toLowerCase();
        return name.contains(query) ||
            role.contains(query) ||
            comp.contains(query);
      }).toList();
      emit(
        ContactsLoaded(
          allContacts: all,
          filteredContacts: filtered,
          searchQuery: query,
        ),
      );
    }
  }
}
