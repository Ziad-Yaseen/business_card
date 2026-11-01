import 'package:business_card/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
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
  });
  final String title;
  final String subTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                fontWeight: .w600,
                color: AppAccent.primaryText[0],
              ),
            ),
            Text(
              subTitle,
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                color: const Color(0xFF5F636A),
                fontWeight: .w500,
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
        ),
      ],
    );
  }
}
