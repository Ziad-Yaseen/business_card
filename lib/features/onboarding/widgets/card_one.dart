import 'dart:math' as math;

import 'package:business_card/features/onboarding/widgets/onboarding_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardOne extends StatelessWidget {
  const CardOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: .center,
        children: [
          Transform.rotate(
            angle: -6 * math.pi / 180,
            child: Container(
              padding: EdgeInsets.all(18.w),
              width: 250.w,
              height: 152.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.r),
                gradient: const LinearGradient(
                  begin: AlignmentGeometry.topLeft,
                  end: AlignmentGeometry.bottomRight,
                  colors: [Color(0xFF2A2D34), Color(0xFF0F1013)],
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 18),
                    blurRadius: 34,
                    spreadRadius: 0,
                    color: const Color(0xFF15171A).withValues(alpha: 0.3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD63A10),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Gap(16.h),
                  Container(
                    width: 124.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  Gap(9.h),
                  Container(
                    width: 86.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 87.h,
            right: 18.3.w,
            child: const OnboardingCard(
              angel: 7,
              text: 'Phone',
              color: Color(0xFF1E6B4E),
            ),
          ),

          Positioned(
            top: 65.h,
            left: 21.w,
            child: const OnboardingCard(
              angel: -6,
              text: 'LinkedIn',
              color: Color(0xFF1F47C9),
            ),
          ),

          Positioned(
            bottom: 42.65.h,
            right: 29.0.w,
            child: const OnboardingCard(
              angel: -4,
              text: 'Portfolio',
              color: Color(0xFF6B33C8),
            ),
          ),

          Positioned(
            bottom: 47.2.h,
            left: 32.75.w,
            child: const OnboardingCard(
              angel: 5,
              text: 'GitHub',
              color: Color(0xFFD63A10),
            ),
          ),
        ],
      ),
    );
  }
}
