import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    primaryColor: AppAccent.presets[0].light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppAccent.bg[0],
    appBarTheme: AppBarTheme(
      backgroundColor: AppAccent.bg[0],
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.appbarTItle(true),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(56.h),
        shape: const StadiumBorder(),
        elevation: 0,
        textStyle: AppTextStyles.fillefButtonText(true),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(52.h),
        shape: const StadiumBorder(),
        textStyle: AppTextStyles.fillefButtonText(true),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        iconColor: const Color(0xffFFFFFF),
        backgroundColor: AppAccent.splashBg,
        overlayColor: AppAccent.splashBg.withValues(alpha: 0.4),
        foregroundColor: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(9999),
        ),
        textStyle: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: .w700),
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        fixedSize: Size(44.w, 44.w),
        minimumSize: Size(44.w, 44.w),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: false,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
    ),

    chipTheme: ChipThemeData(
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      shape: const StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 6.w),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(12.r)),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.r),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppAccent.bg[1],
    appBarTheme: AppBarTheme(
      backgroundColor: AppAccent.bg[1],
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.appbarTItle(false),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(56.h),
        shape: const StadiumBorder(),
        elevation: 0,
        textStyle: AppTextStyles.fillefButtonText(false),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(52.h),
        shape: const StadiumBorder(),
        textStyle: AppTextStyles.fillefButtonText(false),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: AppTextStyles.fillefButtonText(false),
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        fixedSize: Size(44.w, 44.w),
        minimumSize: Size(44.w, 44.w),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: false,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
    ),

    chipTheme: ChipThemeData(
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      shape: const StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 6.w),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(12.r)),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.r),
      ),
    ),
  );
}
