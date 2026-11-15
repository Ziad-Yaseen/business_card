import 'package:business_card/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CardData extends StatelessWidget {
  const CardData({
    super.key,
    required this.card,
    required this.color,
    required this.subTitle,
    required this.title,
  });
  final Widget card;
  final Color color;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Container(
          width: double.infinity,
          height: 384.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: card,
        ),
        Gap(26.h),
        Text(
          title,
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 34.sp,
            fontWeight: .bold,
            letterSpacing: -0.85,
            color: AppAccent.primaryText[0],
          ),
        ),
        Gap(12.h),
        Text(
          subTitle,
          style: GoogleFonts.dmSans(
            fontSize: 16.sp,
            fontWeight: .normal,
            color: AppAccent.secoundaryText[0],
          ),
        ),
      ],
    );
  }
}
