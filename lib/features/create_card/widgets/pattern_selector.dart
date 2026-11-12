import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/create_card/cubit/create_card_cubit.dart';
import 'package:business_card/features/create_card/cubit/create_card_state.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatternSelector extends StatelessWidget {
  const PatternSelector({super.key});

  static const _patterns = [
    CardPattern.rings,
    CardPattern.stripes,
    CardPattern.none,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateCardCubit, CreateCardState, (CardPattern, int)>(
      selector: (state) => (state.pattern, state.colorIndex),
      builder: (context, value) {
        final (selected, colorIndex) = value;
        final cubit = context.read<CreateCardCubit>();
        final base = AppAccent.presets[colorIndex].light;

        return Row(
          spacing: 12.w,
          children: [
            for (final pattern in _patterns)
              Expanded(
                child: _PatternItem(
                  pattern: pattern,
                  color: base,
                  isActive: selected == pattern,
                  onTap: () => cubit.patternChanged(pattern),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PatternItem extends StatelessWidget {
  const _PatternItem({
    required this.pattern,
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  final CardPattern pattern;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;

  static const _cardW = 342.0;
  static const _cardH = 196.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: _cardW / _cardH,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, Color.lerp(color, Colors.black, 0.35)!],
            ),
            border: Border.all(
              color: Color(isActive ? 0xFF15171A : 0xFFD8D2C3),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _cardW,
                height: _cardH,
                child: Stack(
                  children: [
                    CardPatternLayer(
                      pattern: pattern,
                      lineColor: Colors.white.withAlpha(30),
                      glossColor: Colors.white.withAlpha(40),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}