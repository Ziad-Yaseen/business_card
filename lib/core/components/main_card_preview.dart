import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MainCardPreview extends StatelessWidget {
  const MainCardPreview({
    super.key,
    required this.card,
    this.addSpacer = false,
  });

  final CardModel card;
  final bool addSpacer;

  String get _initials {
    final f = card.firstName.trim();
    final l = card.lastName.trim();
    final text = '${f.isEmpty ? '' : f[0]}${l.isEmpty ? '' : l[0]}';
    return text.isEmpty ? '?' : text.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final base = AppAccent.presets[card.cardColor].light;
    final name = card.displayName.isEmpty ? 'Your name' : card.displayName;
    final company = (card.company ?? '').trim();
    final email = card.email.isEmpty ? '' : card.email.first;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [base, Color.lerp(base, Colors.black, 0.35)!],
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
              pattern: card.pattern,
              lineColor: Colors.white.withAlpha(30),
              glossColor: Colors.white.withAlpha(40),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (company.isNotEmpty) ...[
                        Gap(8.w),
                        _CompanyContainer(company: company),
                      ],
                    ],
                  ),
                  Gap(4.h),
                  Text(
                    card.jobTitle.isEmpty ? 'Job title' : card.jobTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Gap(10.h),
                  if (addSpacer) const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Gap(8.w),
                      _Profile(name: _initials),
                    ],
                  ),
                ],
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
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        company,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 11.sp,
          letterSpacing: 0.88,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 2,
        ),
      ),
      child: Text(
        name,
        style: GoogleFonts.bricolageGrotesque(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}