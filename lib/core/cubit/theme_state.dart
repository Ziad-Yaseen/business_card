import 'package:equatable/equatable.dart';
import 'package:material_ui/material_ui.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.colorIndex, required this.mode});

  final int colorIndex;
  final ThemeMode mode;

  ThemeState copyWith({int? colorIndex, ThemeMode? mode}) => ThemeState(
    colorIndex: colorIndex ?? this.colorIndex,
    mode: mode ?? this.mode,
  );

  @override
  List<Object?> get props => [colorIndex, mode];
}
