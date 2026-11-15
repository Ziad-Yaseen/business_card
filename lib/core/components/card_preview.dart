import 'package:business_card/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'card_patterns.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({
    super.key,
    this.pattern = CardPattern.none,
    this.lightContent = true,
    this.addSpacer = false,
  });

  final CardPattern pattern;
  final bool lightContent;
  final bool addSpacer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFE4CB), Color(0xFFE0CFA9)],
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -8),
            blurRadius: 22,
            color: Color.fromRGBO(0, 0, 0, 0.22),
          ),
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 28,
            color: Color.fromRGBO(0, 0, 0, 0.12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            CardPatternLayer(
              pattern: pattern,
              lineColor: Colors.black.withAlpha(30),
              glossColor: Colors.black.withAlpha(40),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 22.w),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          'Ziad Yaseen',
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 24.sp,
                            color: const Color(0xFF15171A),
                            fontWeight: .w700,
                          ),
                        ),
                        const _CompanyContainer(company: 'Company'),
                      ],
                    ),
                    Gap(4.h),
                    Text(
                      'Mobile App Developer',
                      style: GoogleFonts.dmSans(
                        fontSize: 14.sp,
                        fontWeight: .w500,
                        color: AppAccent.primaryText[0].withValues(
                          alpha: lightContent ? 85 : 90,
                        ),
                      ),
                    ),
                    Gap(44.h),

                    if (addSpacer) const Spacer(),

                    Row(
                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .end,
                      children: [
                        Text(
                          'ziadyaseen.dev@gmail.com',
                          style: GoogleFonts.dmSans(
                            color: AppAccent.primaryText[0],
                            fontSize: 13.sp,
                          ),
                        ),
                        const _profile(name: 'ZY'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyContainer extends StatelessWidget {
  const _CompanyContainer({required this.company});
  final String company;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFF15171A).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        company,
        style: GoogleFonts.dmSans(
          color: AppAccent.primaryText[0],
          fontSize: 11.sp,
          letterSpacing: 0.88,
          fontWeight: .w600,
        ),
      ),
    );
  }
}

class _profile extends StatelessWidget {
  const _profile({required this.name, this.image, this.lightContent = true});
  final bool lightContent;
  final String name;
  final String? image;

  @override
  Widget build(BuildContext context) {
    const Color lightColor = Color(0xFFFFFFFF);
    const Color darkColor = Color(0xFF333333);
    final Color color = lightContent ? darkColor : lightColor;
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        shape: .circle,
        border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
      ),
      child: Text(
        name,
        style: GoogleFonts.bricolageGrotesque(
          color: color,
          fontSize: 19,
          fontWeight: .w700,
        ),
      ),
    );
  }
}
