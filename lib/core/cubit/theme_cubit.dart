import 'package:business_card/core/helpers/prefs_helper.dart';
import 'package:business_card/core/keys/prefs_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(colorIndex: _readColor(), mode: _readMode()));

  int numberOfColors = 6;

  static int _readColor() {
    final saved = PrefsHelper.getInt(PrefsKeys.themeColor) ?? 0;
    return (saved < 0 || saved >= 6) ? 0 : saved;
  }

  static ThemeMode _readMode() {
    final saved = PrefsHelper.getInt(PrefsKeys.themeMode);
    if (saved == null || saved < 0 || saved >= ThemeMode.values.length) {
      return ThemeMode.system;
    }
    return ThemeMode.values[saved];
  }

  void select(int index) {
    if (index < 0 || index >= numberOfColors || index == state.colorIndex) {
      return;
    }
    PrefsHelper.setInt(PrefsKeys.themeColor, index);
    emit(state.copyWith(colorIndex: index));
  }

  void setMode(ThemeMode mode) {
    if (mode == state.mode) return;
    PrefsHelper.setInt(PrefsKeys.themeMode, mode.index);
    emit(state.copyWith(mode: mode));
  }
}
