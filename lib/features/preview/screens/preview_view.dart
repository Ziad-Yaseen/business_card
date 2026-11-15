import 'package:business_card/core/components/item_container.dart';
import 'package:business_card/core/components/main_back_button.dart';
import 'package:business_card/core/components/main_card_preview.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key, required this.card});
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            children: [
              Gap(8.h),
              const _PreviewAppBar(),
              Gap(10.h),
              MainCardPreview(card: card),
              Gap(10.h),
              const _QrCodeViewWidget(
                link: 'ziad.github.io/card/#v1.H4sIAAAAAAAA',
              ),
              Gap(14.h),
              _PreviewActionButtons(share: () {}, save: () {}, copy: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrCodeViewWidget extends StatelessWidget {
  const _QrCodeViewWidget({this.link = 'Ziad Link'});
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        color: AppAccent.cardBg(context),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 0,
            color: AppAccent.shadowColor.withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(color: Colors.red, width: 172.w, height: 172.w),
          Gap(14.h),
          _QRLinkWidget(link: link),
          Gap(10.h),
          Text(
            'Scan to open this card, no app needed',
            style: GoogleFonts.dmSans(
              fontSize: 13.sp,
              color: AppAccent.secoundaryText(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewAppBar extends StatelessWidget {
  const _PreviewAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const MainBackButton(),
        Gap(12.w),
        Text(
          'Preview',
          style: GoogleFonts.bricolageGrotesque(
            fontSize: 24.sp,
            fontWeight: .w700,
            letterSpacing: -0.48,
          ),
        ),
        const Spacer(),
        ItemContainer(
          child: IconButton(icon: const Icon(Iconsax.edit_2), onPressed: () {}),
        ),
        Gap(12.w),
        ItemContainer(
          child: IconButton(icon: const Icon(Iconsax.more), onPressed: () {}),
        ),
      ],
    );
  }
}

class _QRLinkWidget extends StatelessWidget {
  const _QRLinkWidget({required this.link});
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 14.w, right: 8.w),
      decoration: BoxDecoration(
        color: AppAccent.cardBg3(context),
        borderRadius: BorderRadius.circular(14.r),
        border: context.isDark ? Border.all(color: AppAccent.darkBorder) : null,
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: Text(
              link,
              maxLines: 2,
              overflow: .fade,
              style: GoogleFonts.dmMono(
                fontWeight: .w400,
                fontSize: 13.sp,
                color: AppAccent.primaryText(context),
              ),
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppAccent.cardBg(context),
            ),
            onPressed: () {},
            icon: Icon(Iconsax.copy, size: 18.sp),
          ),
        ],
      ),
    );
  }
}

class _PrevActionButton extends StatelessWidget {
  const _PrevActionButton({
    required this.label,
    required this.icon,
    this.isPrimary = false,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          surfaceTintColor: context.isDark
              ? AppAccent.presets[state.colorIndex].dark.withValues(alpha: 0.05)
              : AppAccent.presets[state.colorIndex].light.withValues(
                  alpha: 0.005,
                ),
          overlayColor: context.isDark
              ? AppAccent.presets[state.colorIndex].dark.withValues(alpha: 0.05)
              : AppAccent.presets[state.colorIndex].light.withValues(
                  alpha: 0.005,
                ),
          backgroundColor: isPrimary
              ? context.isDark
                    ? AppAccent.presets[state.colorIndex].dark
                    : AppAccent.presets[state.colorIndex].light
              : AppAccent.cardBg(context),
        ),
        onPressed: onTap,
        label: Text(
          label,
          style: GoogleFonts.dmSans(
            color: isPrimary
                ? AppAccent.primaryText3(context)
                : AppAccent.primaryText(context),
            fontWeight: .w600,
            fontSize: 15.sp,
          ),
        ),
        icon: Icon(
          icon,
          size: 18.sp,
          color: isPrimary
              ? AppAccent.primaryText3(context)
              : AppAccent.primaryText(context),
        ),
      ),
    );
  }
}

class _PreviewActionButtons extends StatelessWidget {
  const _PreviewActionButtons({
    required this.share,
    required this.save,
    required this.copy,
  });
  final VoidCallback share;
  final VoidCallback save;
  final VoidCallback copy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PrevActionButton(
            label: 'Share',
            icon: Icons.share_outlined,
            isPrimary: true,
            onTap: share,
          ),
        ),
        Gap(10.w),
        Expanded(
          child: _PrevActionButton(
            label: 'Save QR',
            icon: Iconsax.import_1,
            onTap: save,
          ),
        ),
        Gap(10.w),
        Expanded(
          child: _PrevActionButton(
            label: 'Copy',
            icon: Iconsax.copy,
            onTap: copy,
          ),
        ),
      ],
    );
  }
}
