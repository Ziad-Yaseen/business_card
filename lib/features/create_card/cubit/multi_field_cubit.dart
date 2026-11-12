import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiFieldState {
  const MultiFieldState(this.controllers);

  final List<TextEditingController> controllers;

  int get count => controllers.length;
}

class MultiFieldCubit extends Cubit<MultiFieldState> {
  MultiFieldCubit({
    required this.max,
    required this.onChanged,
    List<String> initial = const [],
  }) : super(const MultiFieldState([])) {
    final values = initial.isEmpty ? [''] : initial.take(max);
    emit(MultiFieldState(values.map(_create).toList()));
  }

  final int max;

  final ValueChanged<List<String>> onChanged;

  final List<TextEditingController> _retired = [];

  bool get canAdd => state.count < max;

  TextEditingController _create(String text) =>
      TextEditingController(text: text)..addListener(_notify);

  void _notify() {
    onChanged(
      state.controllers
          .map((c) => c.text.trim())
          .where((t) => t.isNotEmpty)
          .toList(),
    );
  }

  void add() {
    if (!canAdd) return;
    emit(MultiFieldState([...state.controllers, _create('')]));
  }

  void remove(int index) {
    if (state.count == 1) {
      state.controllers.first.clear();
      return;
    }
    final list = [...state.controllers];
    final removed = list.removeAt(index)..removeListener(_notify);
    _retired.add(removed);
    emit(MultiFieldState(list));
    _notify();
  }

  @override
  Future<void> close() {
    for (final c in [...state.controllers, ..._retired]) {
      c.dispose();
    }
    return super.close();
  }
}
