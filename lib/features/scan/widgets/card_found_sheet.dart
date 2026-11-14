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

class CardFoundSheet extends StatelessWidget {
  const CardFoundSheet({
    super.key,
    required this.card,
    required this.saving,
    required this.onSave,
    required this.onScanAgain,
  });

  final CardModel card;
  final bool saving;
  final VoidCallback onSave;
  final VoidCallback onScanAgain;

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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 14.h),
      decoration: BoxDecoration(
        color: AppAccent.cardBg(context),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF22A06B),
                  shape: BoxShape.circle,
                ),
              ),
              Gap(8.w),
              Text(
                'Card found',
                style: GoogleFonts.dmSans(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppAccent.secoundaryText(context),
                ),
              ),
            ],
          ),
          Gap(14.h),
          Row(
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppAccent.presets[card.cardColor].light,
                      AppAccent.presets[card.cardColor].dark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  _initials,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Gap(14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: AppAccent.primaryText(context),
                      ),
                    ),
                    Text(
                      card.jobTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontSize: 14.sp,
                        color: AppAccent.secoundaryText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(14.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [for (final label in _chips) _Chip(label: label)],
          ),
          Gap(14.h),
          Row(
            children: [
              Icon(
                Iconsax.lock,
                size: 13.sp,
                color: AppAccent.secoundaryText(context),
              ),
              Gap(6.w),
              Expanded(
                child: Text(
                  'Saved cards are read-only and stay on this device.',
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: AppAccent.secoundaryText(context),
                  ),
                ),
              ),
            ],
          ),
          Gap(16.h),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (_, theme) => TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 56.h),
                backgroundColor: context.isDark
                    ? AppAccent.presets[theme.colorIndex].dark
                    : AppAccent.presets[theme.colorIndex].light,
              ),
              onPressed: saving ? null : onSave,
              child: saving
                  ? SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: const CircularProgressIndicator(strokeWidth: 2.5),
                    )
                  : const Text('Save to contacts'),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: saving ? null : onScanAgain,
              child: const Text('Scan again'),
            ),
          ),
        ],
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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppAccent.border(context)),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: AppAccent.primaryText(context),
        ),
      ),
    );
  }
}
