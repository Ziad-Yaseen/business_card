import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingCard extends StatelessWidget {
  const new({
    super.key,
    required this.angel,
    required this.text,
    required this.color,
  });
  final double angel;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angel * math.pi / 180,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF15171A).withValues(alpha: 0.14),
              offset: const Offset(0, 8),
              blurRadius: 18,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            Gap(6.5.w),
            Text(
              text,
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                fontWeight: .w700,
                color: const Color(0xFF15171A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
