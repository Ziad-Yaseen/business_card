import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    required this.title,
    this.subTitle = '',
    this.controller,
    this.validator,
    this.hint,
    this.onChanged,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.enableInteractiveSelection = false,
  });

  final String title;
  final String subTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final String? initialValue;

  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? suffixIcon;
  final bool enableInteractiveSelection;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppAccent.primaryText(context),
              ),
            ),
            Text(
              subTitle,
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                color: AppAccent.secoundaryText(context),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Gap(6.h),
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) => TextFormField(
            controller: controller,
            initialValue: initialValue,
            onChanged: onChanged,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            cursorColor: context.isDark
                ? AppAccent.presets[state.colorIndex].dark
                : AppAccent.presets[state.colorIndex].light,
            cursorErrorColor: Colors.red,
            enableInteractiveSelection: enableInteractiveSelection,
            style: GoogleFonts.dmSans(
              fontSize: 16.sp,
              color: AppAccent.primaryText(context),
            ),
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffixIcon,
              hintStyle: GoogleFonts.dmSans(
                color: const Color(0xFF757575),
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
