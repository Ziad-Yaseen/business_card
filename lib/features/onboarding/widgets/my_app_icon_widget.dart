import 'package:business_card/core/constants/app_colors.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppIconWidget extends StatelessWidget {
  const MyAppIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'card',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24.sp,
              fontWeight: .w800,
              letterSpacing: -0.72,
              color: AppAccent.primaryText[0],
            ),
          ),
          TextSpan(
            text: '.',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24.sp,
              fontWeight: .w800,
              letterSpacing: -0.72,
              color: AppAccent.splashBg,
            ),
          ),
        ],
      ),
    );
  }
}
