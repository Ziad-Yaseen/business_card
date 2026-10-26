import 'package:business_card/core/routes/route_names.dart';
import 'package:business_card/features/splash/widgets/app_icon.dart';
import 'package:business_card/features/splash/widgets/splash_bg.dart';
import 'package:business_card/features/splash/widgets/splash_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(RouteNames.onboarding);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashBG(
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const SplashCardsWidget(),
            Gap(55.h),
            const AppIconWidget(),
            Gap(8.h),
            Text(
              'Your details, one scan away',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: .w500,
                fontSize: 17.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
