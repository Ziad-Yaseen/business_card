import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/styles/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class AppThemes {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppAccent.presets[0].light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppAccent.bg[0],
    appBarTheme: AppBarTheme(
      backgroundColor: AppAccent.bg[0],
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(56.h),
        shape: const StadiumBorder(),
        elevation: 0,
        textStyle: AppTextStyles.fillefButtonText(true)
            .copyWith(inherit: false),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(52.h),
        shape: const StadiumBorder(),
        textStyle: AppTextStyles.fillefButtonText(true)
            .copyWith(inherit: false),
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
        textStyle: GoogleFonts.dmSans(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ).copyWith(inherit: false),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.5.w),
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: Color(0xFFD8D2C3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: Color(0xFFD8D2C3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: Color.lerp(const Color(0xFFD8D2C3), Colors.black, 0.2)!,
        ),
      ),
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

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppAccent.presets[0].dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppAccent.bg[1],
    appBarTheme: AppBarTheme(
      backgroundColor: AppAccent.bg[1],
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(56.h),
        shape: const StadiumBorder(),
        elevation: 0,
        textStyle: AppTextStyles.fillefButtonText(false)
            .copyWith(inherit: false),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(52.h),
        shape: const StadiumBorder(),
        textStyle: AppTextStyles.fillefButtonText(false)
            .copyWith(inherit: false),
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
        textStyle: GoogleFonts.dmSans(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ).copyWith(inherit: false),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.5.w),
      fillColor: const Color(0xFF181A1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: Color(0xFF33363D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: Color(0xFF33363D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: Color.lerp(const Color(0xFF33363D), Colors.black, 0.2)!,
        ),
      ),
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
