import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

Future<bool> showCardFoundSheet(BuildContext context, CardModel card) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 0,
    isScrollControlled: true,
    builder: (_) => CardFoundSheet(card: card),
  );
  return result ?? false;
}

class CardFoundSheet extends StatelessWidget {
  const CardFoundSheet({super.key, required this.card});

  final CardModel card;

  String get _initials {
    final f = card.firstName.trim();
    final l = card.lastName.trim();
    final text = '${f.isEmpty ? '' : f[0]}${l.isEmpty ? '' : l[0]}';
    return text.isEmpty ? '?' : text.toUpperCase();
  }

  List<String> get _chips => [
    if (card.email.isNotEmpty) 'Email',
    if (card.phone.isNotEmpty) 'Phone',
    if (card.linkedIn.trim().isNotEmpty) 'LinkedIn',
    if ((card.github ?? '').isNotEmpty) 'GitHub',
    if ((card.portfolio ?? '').isNotEmpty) 'Portfolio',
    if ((card.instagram ?? '').isNotEmpty) 'Instagram',
    if ((card.facebook ?? '').isNotEmpty) 'Facebook',
    if ((card.tiktok ?? '').isNotEmpty) 'TikTok',
    if ((card.x ?? '').isNotEmpty) 'X',
    if (card.more?.isNotEmpty ?? false) 'More',
  ];

  @override
  Widget build(BuildContext context) {
    final accent = AppAccent.presets[card.cardColor];
    final avatarColor = context.isDark ? accent.dark : accent.light;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppAccent.cardBg(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppAccent.border(context),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Gap(18.h),
              Row(
                children: [
                  Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22A06B),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF22A06B)
                              .withValues(alpha: 0.25),
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  Gap(12.w),
                  Text(
                    'Card found',
                    style: GoogleFonts.dmSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppAccent.secoundaryText(context),
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              Row(
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          avatarColor,
                          Color.lerp(avatarColor, Colors.black, 0.35)!,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: avatarColor.withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      _initials,
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Gap(18.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: AppAccent.primaryText(context),
                          ),
                        ),
                        Text(
                          card.jobTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            fontSize: 16.sp,
                            color: AppAccent.secoundaryText(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(18.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [for (final label in _chips) _Chip(label: label)],
              ),
              Gap(18.h),
              Row(
                children: [
                  Icon(
                    Iconsax.lock,
                    size: 15.sp,
                    color: AppAccent.secoundaryText(context),
                  ),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      'Saved cards are read-only and stay on this device.',
                      style: GoogleFonts.dmSans(
                        fontSize: 13.sp,
                        color: AppAccent.secoundaryText(context),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (_, theme) {
                  final color = context.isDark
                      ? AppAccent.presets[theme.colorIndex].dark
                      : AppAccent.presets[theme.colorIndex].light;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 56.h),
                        backgroundColor: color,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Save to contacts'),
                    ),
                  );
                },
              ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Scan again',
                    style: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppAccent.primaryText(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppAccent.border(context)),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppAccent.primaryText(context),
        ),
      ),
    );
  }
}
