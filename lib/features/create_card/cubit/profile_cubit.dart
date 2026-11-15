import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ProfileType {
  instagram('Instagram', 'Instagram handle', '@your-name'),
  facebook('Facebook', 'Facebook profile', 'facebook.com/your-name'),
  tiktok('TikTok', 'TikTok handle', '@your-name'),
  x('X', 'X handle', '@your-name'),
  more('More', 'More links', 'https://');

  const ProfileType(this.label, this.fieldTitle, this.hint);

  final String label;
  final String fieldTitle;
  final String hint;
}

class ProfilesState {
  const ProfilesState({required this.selected, required this.filled});

  final ProfileType selected;

  final Set<ProfileType> filled;
}

class ProfilesCubit extends Cubit<ProfilesState> {
  ProfilesCubit({
    required this.onChanged,
    Map<ProfileType, String> initial = const {},
  }) : controllers = {
         for (final t in ProfileType.values)
           if (t != ProfileType.more)
             t: TextEditingController(text: initial[t] ?? ''),
       },
       super(
         ProfilesState(
           selected: ProfileType.instagram,
           filled: {
             for (final e in initial.entries)
               if (e.value.trim().isNotEmpty) e.key,
           },
         ),
       ) {
    for (final c in controllers.values) {
      c.addListener(_onText);
    }
  }

  final ValueChanged<Map<ProfileType, String>> onChanged;

  final Map<ProfileType, TextEditingController> controllers;

  void select(ProfileType type) {
    if (type == state.selected) return;
    emit(ProfilesState(selected: type, filled: state.filled));
  }

  void _onText() {
    final values = {
      for (final e in controllers.entries)
        if (e.value.text.trim().isNotEmpty) e.key: e.value.text.trim(),
    };
    final filled = values.keys.toSet();

    if (filled.length != state.filled.length ||
        !filled.containsAll(state.filled)) {
      emit(ProfilesState(selected: state.selected, filled: filled));
    }
    onChanged(values);
  }

  @override
  Future<void> close() {
    for (final c in controllers.values) {
      c.dispose();
    }
    return super.close();
  }
}
