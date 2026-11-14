import 'package:business_card/core/constants/app_colors.dart';
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
  });

  final String title;
  final String subTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final String? initialValue;

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
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursorColor: AppAccent.primaryText(context),
          cursorErrorColor: Colors.red,
          enableInteractiveSelection: false,
          style: GoogleFonts.dmSans(
            fontSize: 16.sp,
            color: AppAccent.primaryText(context),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(
              color: const Color(0xFF757575),
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }
}
