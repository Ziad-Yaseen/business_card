import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:material_ui/material_ui.dart';

class AppAccent extends Equatable {
  const AppAccent(this.name, this.light, this.dark);

  final String name;
  final Color light;
  final Color dark;

  // onBoarding colors
  static const _firstCard = [Color(0xFFF9D9CD), Color(0xFF3A1E15)];
  static const _secondCard = [Color(0xFFD9E2FB), Color(0xFF1B2547)];
  static const _thirdCard = [Color(0xFFD6E9DE), Color(0xFF16302A)];

  static Color firstCardBG(BuildContext context) =>
      context.isDark ? _firstCard[1] : _firstCard[0];

  static Color secondCardBG(BuildContext context) =>
      context.isDark ? _secondCard[1] : _secondCard[0];

  static Color thirdCardBG(BuildContext context) =>
      context.isDark ? _thirdCard[1] : _thirdCard[0];

  /// Text colors

  static const _primaryText = [Color(0xFF15171A), Color(0xFFF4F1EA)];
  static const _secoundaryText = [Color(0xFF5F636A), Color(0xFFA5A9B0)];
  static const _primaryText2 = [Color(0xFFF4F1EA), Color(0xFF0E0F11)];
  static const _unselectedTab = [Color(0xFF5F636A), Color(0xFFA5A9B0)];

  static Color unselectedTab(BuildContext context) =>
      context.isDark ? _unselectedTab[1] : _unselectedTab[0];

  static Color secoundaryText(BuildContext context) =>
      context.isDark ? _secoundaryText[1] : _secoundaryText[0];

  static Color primaryText(BuildContext context) =>
      context.isDark ? _primaryText[1] : _primaryText[0];

  static Color primaryText2(BuildContext context) =>
      context.isDark ? _primaryText2[1] : _primaryText2[0];

  static const _secondaryDot = [Color(0xFFCFC9BA), Color(0xFF3A3D44)];

  static Color secondaryDot(BuildContext context) =>
      context.isDark ? _secondaryDot[1] : _secondaryDot[0];

  /// Background colors

  static const _border = [Color(0xFFDDD7C8), Color(0xFF2B2E34)];

  static const _stroke = [Color(0xFFDDD7C8), Color(0xFF2F3238)];

  static Color stroke(BuildContext context) =>
      context.isDark ? _stroke[1] : _stroke[0];

  static Color border(BuildContext context) =>
      context.isDark ? _border[1] : _border[0];

  static const _cardBg = [Color(0xFFFFFFFF), Color(0xFF181A1E)];

  static const _cardBg2 = [Color(0xFFEEEADF), Color(0xFF262A30)];

  static Color cardBg(BuildContext context) =>
      context.isDark ? _cardBg[1] : _cardBg[0];

  static Color cardBg2(BuildContext context) =>
      context.isDark ? _cardBg2[1] : _cardBg2[0];

  static const _darkLerpedbg = [Color(0xFFEAE5D8), Color(0xFF22252A)];

  static Color darkLerpedbg(BuildContext context) =>
      context.isDark ? _darkLerpedbg[1] : _darkLerpedbg[0];

  /// No cards colors

  static const _noCard1 = [Color(0xB3FFFFFF), Color(0xFF0E0F11)];
  static const _noCard2 = [Color(0xFFEAE5D8), Color(0xFF2B2E34)];
  static const _noCard3 = [Color(0xFFE5E1D8), Color(0xFF2B2E34)];

  static Color noCard1(BuildContext context) =>
      context.isDark ? _noCard1[1] : _noCard1[0];
  static Color noCard2(BuildContext context) =>
      context.isDark ? _noCard2[1] : _noCard2[0];
  static Color noCard3(BuildContext context) =>
      context.isDark ? _noCard3[1] : _noCard3[0];

  // static Color bg(BuildContext context) =>
  //     context.isDark ? const Color(0xFF0E0F11) : const Color(0xFFF4F1EA);

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
  static const Color darkTExt = Color(0xFF1B0B05);

  @override
  List<Object?> get props => [light, dark];
}
