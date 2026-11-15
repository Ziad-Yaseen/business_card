import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:material_ui/material_ui.dart';

extension ThemeModeExtension on BuildContext {
  bool get isDark {
    final mode = watch<ThemeCubit>().state.mode;

    if (mode == ThemeMode.dark) return true;
    if (mode == ThemeMode.light) return false;

    return Theme.of(this).brightness == Brightness.dark;
  }
}
