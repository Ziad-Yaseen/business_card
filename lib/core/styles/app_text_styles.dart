import 'package:business_card/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  static TextStyle _display(
    bool ar,
    double size, {
    double ls = 0,
    FontWeight? weight,
    required Color c,
  }) {
    if (ar) {
      return GoogleFonts.ibmPlexSansArabic(fontSize: size, fontWeight: weight);
    }
    return GoogleFonts.bricolageGrotesque(
      fontSize: size,
      fontWeight: weight,
      letterSpacing: ls,
      color: c,
    );
  }
}

class AppTextStyles {
  static TextStyle splashDiscription({bool arabic = false}) {
    final ar = arabic;
    return AppText._display(
      ar,
      17.sp,
      c: Colors.white.withValues(alpha: 0.95),
      weight: .w500,
    );
  }

  static TextStyle appbarTItle(bool light, {bool arabic = false}) {
    final ar = arabic;
    return ar
        ? AppText._display(
            ar,
            38.sp,
            c: light ? AppAccent.primaryText[0] : AppAccent.primaryText[1],
            weight: .w700,
          )
        : GoogleFonts.bricolageGrotesque(
            fontSize: 38.sp,
            color: light ? AppAccent.primaryText[0] : AppAccent.primaryText[1],
            fontWeight: .w700,
          );
  }

  static TextStyle fillefButtonText(bool light) {
    return GoogleFonts.dmSans(
      fontSize: 17.sp,
      fontWeight: .w600,
      color: light ? Colors.white : AppAccent.darkTExt,
    );
  }
}
