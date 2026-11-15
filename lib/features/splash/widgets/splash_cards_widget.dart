import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SplashCardsWidget extends StatelessWidget {
  const SplashCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .none,
      alignment: .center,
      children: [
        Transform.rotate(
          angle: -8 * math.pi / 180,
          child: Container(
            width: 280.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE8DECD),
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF691103).withValues(alpha: 0.38),
                  offset: const Offset(0, 18),
                  blurRadius: 36,
                  spreadRadius: -8,
                ),
              ],
            ),
          ),
        ),

        // Padding(
        //   padding: EdgeInsets.only(right: 40.w, top: 30.h),
        //   child: Transform.rotate(
        //     angle: -10 * math.pi / 180,
        //     child: Container(
        //       width: 280.w,
        //       height: 180.h,
        //       decoration: BoxDecoration(
        //         color: const Color(0xFF1F242C),
        //         borderRadius: BorderRadius.circular(24.r),
        //         boxShadow: [
        //           BoxShadow(
        //             color: const Color(0xFF5A1004).withValues(alpha: 0.45),
        //             offset: const Offset(0, 24),
        //             blurRadius: 48,
        //             spreadRadius: -12,
        //           ),

        //           BoxShadow(
        //             color: Colors.black.withValues(alpha: 0.25),
        //             offset: const Offset(0, 12),
        //             blurRadius: 24,
        //             spreadRadius: -8,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        Positioned(
          top: 13,
          right: 28,
          child: Transform.rotate(
            angle: -10 * math.pi / 180,
            child: Container(
              width: 280.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F242C),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5A1004).withValues(alpha: 0.45),
                    offset: const Offset(0, 24),
                    blurRadius: 48,
                    spreadRadius: -12,
                  ),

                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    offset: const Offset(0, 12),
                    blurRadius: 24,
                    spreadRadius: -8,
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: 10,
          right: 20,
          child: Transform.rotate(
            angle: -1 * math.pi / 180,
            child: Container(
              width: 280.w,
              height: 180.h,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5A1004).withValues(alpha: 0.45),
                    offset: const Offset(0, 24),
                    blurRadius: 48,
                    spreadRadius: -12,
                  ),

                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    offset: const Offset(0, 12),
                    blurRadius: 24,
                    spreadRadius: -8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Container(
                    width: 124.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.r),
                      color: const Color(0xFF1A1F26),
                    ),
                  ),
                  Gap(8.5.h),
                  Container(
                    width: 84.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.r),
                      color: const Color(0xFFC8C3BC),
                    ),
                  ),
                  Gap(8.15.h),
                  Container(
                    width: 106.w,
                    height: 7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.r),
                      color: const Color(0xFFE3DFD8),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: .bottomEnd,
                    child: Image.asset(
                      'assets/images/qr.webp',
                      width: 66.w,
                      height: 66.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
