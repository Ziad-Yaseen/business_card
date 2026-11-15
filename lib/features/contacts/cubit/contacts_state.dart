import 'package:business_card/data/models/card_model.dart';
import 'package:equatable/equatable.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object?> get props => [];
}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  const ContactsLoaded({
    required this.allContacts,
    required this.filteredContacts,
    this.searchQuery = '',
  });

  final List<CardModel> allContacts;
  final List<CardModel> filteredContacts;
  final String searchQuery;

  @override
  List<Object?> get props => [allContacts, filteredContacts, searchQuery];
}

class ContactsError extends ContactsState {
  const ContactsError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
