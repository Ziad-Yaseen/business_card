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
  });
  final String title;
  final String subTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hint;

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
                color: AppAccent.primaryText[0],
              ),
            ),
            Text(
              subTitle,
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                color: const Color(0xFF5F636A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Gap(6.h),
        TextFormField(
          controller: controller,
          validator: validator,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursorColor: Color.lerp(const Color(0xFFD8D2C3), Colors.black, 0.2)!,
          cursorErrorColor: Colors.red,
          enableInteractiveSelection: false,
          style: GoogleFonts.dmSans(
            fontSize: 16.sp,
            color: AppAccent.primaryText[0],
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
