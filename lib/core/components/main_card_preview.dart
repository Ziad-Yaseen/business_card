import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MainCardPreview extends StatelessWidget {
  const MainCardPreview({
    super.key,
    required this.pattern,
    this.lightContent = true,
  });
  final CardPattern pattern;
  final bool lightContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A55E0), Color(0xFF1636A0)],
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
            color: Colors.black.withValues(alpha: 0.1),
          ),
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
            color: Colors.black.withValues(alpha: 0.1),
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
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
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
                            color: lightContent
                                ? Colors.white
                                : const Color(0xFF15171A),
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
                        color: lightContent
                            ? Colors.white
                            : AppAccent.primaryText[0].withValues(
                                alpha: lightContent ? 85 : 90,
                              ),
                      ),
                    ),
                    Gap(10.h),

                    Row(
                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .end,
                      children: [
                        Text(
                          'ziadyaseen.dev@gmail.com',
                          style: GoogleFonts.dmSans(
                            color: lightContent
                                ? Colors.white
                                : AppAccent.primaryText[0],
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
  const _CompanyContainer({required this.company, this.lightContent = true});
  final String company;
  final bool lightContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: lightContent
            ? Colors.white.withValues(alpha: 0.18)
            : const Color(0xFF15171A).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        company,
        style: GoogleFonts.dmSans(
          color: lightContent ? Colors.white : AppAccent.primaryText[0],
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
    final Color color = lightContent ? lightColor : darkColor;
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
