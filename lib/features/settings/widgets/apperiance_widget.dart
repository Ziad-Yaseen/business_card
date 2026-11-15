import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/features/settings/widgets/settings_color_selector.dart';
import 'package:business_card/features/settings/widgets/settings_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class ApperianceWidget extends StatelessWidget {
  const ApperianceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      text: 'APPEARANCE',
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 13.0.w, horizontal: 16.w),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Theme',
                  style: GoogleFonts.dmSans(
                    fontWeight: .w500,
                    fontSize: 16.sp,
                    color: AppAccent.primaryText(context),
                  ),
                ),
                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (_, state) {
                    final cubit = context.read<ThemeCubit>();
                    return _ThemeSelector(
                      selectedMode: state.mode,
                      onChanged: (value) {
                        cubit.setMode(value);
                      },
                      selectedColor: context.isDark
                          ? AppAccent.presets[state.colorIndex].dark
                          : AppAccent.presets[state.colorIndex].light,
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(color: AppAccent.stroke(context)),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     vertical: 13.0.w,
          //     horizontal: 16.w,
          //   ),
          //   child: Row(),
          // ),
          // const Divider(color: Color(0xFFDDD7C8)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 13.0.w, horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      'App color',
                      style: GoogleFonts.dmSans(
                        fontSize: 16.sp,
                        fontWeight: .w500,
                        color: AppAccent.primaryText(context),
                      ),
                    ),
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (_, state) => TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          backgroundColor: context.isDark
                              ? AppAccent.presets[state.colorIndex].dark
                              : AppAccent.presets[state.colorIndex].light,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Example',
                          style: GoogleFonts.dmSans(
                            fontSize: 13.sp,
                            fontWeight: .w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(10.h),
                const SettingsColorSelectorWidget(),
                Gap(10.h),
                Text(
                  'Used for buttons and highlights. Each card has its own color.',
                  style: GoogleFonts.dmSans(
                    fontSize: 13.sp,
                    color: AppAccent.secoundaryText(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsColorSelector {}

class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector({
    required this.selectedMode,
    required this.onChanged,
    this.selectedColor = const Color(0xFF15171A),
  });

  final ThemeMode selectedMode;
  final ValueChanged<ThemeMode> onChanged;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    const items = [
      (label: 'Light', mode: ThemeMode.light),
      (label: 'Dark', mode: ThemeMode.dark),
      (label: 'System', mode: ThemeMode.system),
    ];

    return Container(
      padding: const .all(3),
      decoration: BoxDecoration(
        color: AppAccent.cardBg2(context),
        borderRadius: .circular(19.r),
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: 2,
        children: [
          for (final item in items)
            _ThemeOption(
              label: item.label,
              isSelected: selectedMode == item.mode,
              onTap: () => onChanged(item.mode),
              selectedColor: selectedColor,
            ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = const Color(0xFF15171A),
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: .opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 34,
        padding: const .symmetric(horizontal: 13),
        alignment: .center,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: .circular(16.r),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: .w600,
            color: isSelected
                ? const Color(0xFFF4F1EA)
                : const Color(0xFF5F636A),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}
