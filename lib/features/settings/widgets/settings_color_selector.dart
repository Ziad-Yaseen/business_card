import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

class SettingsColorSelectorWidget extends StatelessWidget {
  const SettingsColorSelectorWidget({super.key});

  static const _count = 6;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeState, int>(
      selector: (state) => state.colorIndex,
      builder: (context, selected) {
        final cubit = context.read<ThemeCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _count,
            (index) => Expanded(
              child: _ColorItem(
                isSelected: selected == index,
                color: AppAccent.presets[index].light,
                onTap: () => cubit.select(index),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color darkerBorderColor = Color.lerp(color, Colors.black, 0.2)!;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(isSelected ? 4 : 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: darkerBorderColor, width: 3)
              : null,
        ),
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: darkerBorderColor, width: 1),
          ),
        ),
      ),
    );
  }
}
