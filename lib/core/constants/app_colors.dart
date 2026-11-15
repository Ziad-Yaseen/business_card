import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppAccent extends Equatable {
  const AppAccent(this.name, this.light, this.dark);

  final String name;
  final Color light;
  final Color dark;

  static const persimmon = AppAccent(
    'Persimmon',
    Color(0xFFD63A10),
    Color(0xFFFF6B3D),
  );
  static const ocean = AppAccent('Ocean', Color(0xFF2A55E0), Color(0xFF7D9BFF));
  static const forest = AppAccent(
    'Forest',
    Color(0xFF1E7A55),
    Color(0xFF4CCB94),
  );
  static const plum = AppAccent('Plum', Color(0xFF7B3FE0), Color(0xFFB692FF));
  static const rose = AppAccent('Rose', Color(0xFFC2185B), Color(0xFFFF7BAA));
  static const ink = AppAccent('Ink', Color(0xFF15171A), Color(0xFFF4F1EA));

  static const presets = <AppAccent>[persimmon, ocean, forest, plum, rose, ink];

  static const defaultAccent = persimmon;

  static const bg = [Color(0xFFF4F1EA), Color(0xFF0E0F11)];

  static const splashBg = Color(0xFFD63717);
  static const primaryText = [Color(0xFF15171A), Color(0xFFF4F1EA)];
  static const secoundaryText = [Color(0xFF5F636A), Color(0xFFA5A9B0)];
  static const Color darkTExt = Color(0xFF1B0B05);

  @override
  List<Object?> get props => [light, dark];
}
