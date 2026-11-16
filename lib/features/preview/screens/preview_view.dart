import 'dart:ui';

import 'package:business_card/core/components/item_container.dart';
import 'package:business_card/core/components/main_back_button.dart';
import 'package:business_card/core/components/main_card_preview.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/card_dao.dart';
import 'package:business_card/core/helpers/card_share.dart';
import 'package:business_card/core/helpers/database_helper.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/core/repositories/card_repositories.dart';
import 'package:business_card/core/routes/route_names.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

enum _CardMenu { duplicate, delete }

class PreviewView extends StatefulWidget {
  const PreviewView({super.key, required this.card});
  final CardModel card;

  @override
  State<PreviewView> createState() => _PreviewViewState();
}

class _PreviewViewState extends State<PreviewView> {
  final CardsRepository _repository = CardsRepository(
    CardsDao(DatabaseHelper.instance),
  );

  late CardModel _card = widget.card;

  void _snack(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text), duration: const Duration(seconds: 2)),
      );
  }

  Future<void> _copy(String link) async {
    await Clipboard.setData(ClipboardData(text: link));
    if (!mounted) return;
    _snack('Link copied');
  }

  Future<void> _share(String link) async {
    await SharePlus.instance.share(
      ShareParams(text: link, subject: _card.fullName),
    );
  }

  Future<void> _saveQr(String link) async {
    final painter = QrPainter(
      data: link,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      gapless: true,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Color(0xFF15171A),
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: Color(0xFF15171A),
      ),
    );
    final data = await painter.toImageData(1024, format: ImageByteFormat.png);
    if (data == null) return;
    final bytes = data.buffer.asUint8List();
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(bytes, mimeType: 'image/png')],
        fileNameOverrides: ['card-qr.png'],
      ),
    );
  }

  Future<void> _edit() async {
    final saved = await context.push<bool>(RouteNames.create, extra: _card);
    if (saved != true || !mounted) return;
    final fresh = await _repository.getById(_card.id);
    if (fresh == null || !mounted) return;
    setState(() => _card = fresh);
  }

  Future<void> _duplicate() async {
    try {
      await _repository.save(_card.copyWith(id: CardsRepository.newId()));
      if (!mounted) return;
      _snack('Card duplicated');
    } catch (_) {
      if (!mounted) return;
      _snack('Could not duplicate the card');
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete this card?'),
        content: const Text('This can’t be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await _repository.delete(_card.id);
      if (!mounted) return;
      context.pop(true);
    } catch (_) {
      if (!mounted) return;
      _snack('Could not delete the card');
    }
  }

  void _onMenu(_CardMenu action) {
    switch (action) {
      case _CardMenu.duplicate:
        _duplicate();
      case _CardMenu.delete:
        _delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final link = _card.toShareLink();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            children: [
              Gap(8.h),
              _PreviewAppBar(onEdit: _edit, onMenu: _onMenu),
              Gap(10.h),
              MainCardPreview(card: _card),
              Gap(10.h),
              _QrCodeViewWidget(link: link, onCopy: () => _copy(link)),
              Gap(14.h),
              _PreviewActionButtons(
                share: () => _share(link),
                save: () => _saveQr(link),
                copy: () => _copy(link),
              ),
              Gap(22.h),
              _InThisCard(card: _card),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrCodeViewWidget extends StatelessWidget {
  const _QrCodeViewWidget({required this.link, required this.onCopy});
  final String link;
  final VoidCallback onCopy;

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
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: QrImageView(
              data: link,
              version: QrVersions.auto,
              errorCorrectionLevel: QrErrorCorrectLevel.M,
              size: 172.w,
              padding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              gapless: true,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Color(0xFF15171A),
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Color(0xFF15171A),
              ),
            ),
          ),
          Gap(14.h),
          _QRLinkWidget(link: link, onCopy: onCopy),
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
  const _PreviewAppBar({required this.onEdit, required this.onMenu});
  final VoidCallback onEdit;
  final ValueChanged<_CardMenu> onMenu;

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
          child: IconButton(
            icon: const Icon(Iconsax.edit_2),
            onPressed: onEdit,
          ),
        ),
        Gap(12.w),
        ItemContainer(
          child: PopupMenuButton<_CardMenu>(
            icon: const Icon(Iconsax.more),
            onSelected: onMenu,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: _CardMenu.duplicate,
                child: Row(
                  children: [
                    Icon(Iconsax.copy, size: 18.sp),
                    Gap(10.w),
                    const Text('Duplicate'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: _CardMenu.delete,
                child: Row(
                  children: [
                    Icon(Iconsax.trash, size: 18.sp, color: Colors.red),
                    Gap(10.w),
                    const Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QRLinkWidget extends StatelessWidget {
  const _QRLinkWidget({required this.link, required this.onCopy});
  final String link;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final shown = link.replaceFirst(RegExp(r'^https?://'), '');
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => Container(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 14.w, right: 8.w),
        decoration: BoxDecoration(
          color: context.isDark
              ? AppAccent.presets[state.colorIndex].dark.withValues(alpha: 0.15)
              : AppAccent.presets[state.colorIndex].light.withValues(
                  alpha: 0.15,
                ),
          borderRadius: BorderRadius.circular(14.r),
          border: context.isDark
              ? Border.all(color: AppAccent.darkBorder)
              : null,
        ),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Expanded(
              child: Text(
                shown,
                maxLines: 2,
                overflow: .ellipsis,
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
              onPressed: onCopy,
              icon: Icon(Iconsax.copy, size: 18.sp),
            ),
          ],
        ),
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

class _InThisCard extends StatelessWidget {
  const _InThisCard({required this.card});
  final CardModel card;

  @override
  Widget build(BuildContext context) {
    final rows = <_InfoRow>[
      for (final e in card.email) _InfoRow(Iconsax.sms, 'Email', e),
      for (final p in card.phone) _InfoRow(Iconsax.call, 'Phone', p),
      _InfoRow(Iconsax.link_2, 'LinkedIn', card.linkedIn),
      _InfoRow(Iconsax.link_2, 'GitHub', card.github),
      _InfoRow(Iconsax.link_2, 'Portfolio', card.portfolio),
      _InfoRow(Iconsax.link_2, 'Instagram', card.instagram),
      _InfoRow(Iconsax.link_2, 'Facebook', card.facebook),
      _InfoRow(Iconsax.link_2, 'X', card.x),
      _InfoRow(Iconsax.link_2, 'TikTok', card.tiktok),
      for (final m in card.more ?? const <String>[])
        _InfoRow(Iconsax.link_2, 'Link', m),
    ].where((r) => r.value != null && r.value!.trim().isNotEmpty).toList();

    if (rows.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'IN THIS CARD',
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  fontWeight: .w700,
                  letterSpacing: 0.8,
                  color: AppAccent.secoundaryText(context),
                ),
              ),
              Text(
                'All included in the link',
                style: GoogleFonts.dmSans(
                  fontSize: 12.sp,
                  color: AppAccent.secoundaryText(context),
                ),
              ),
            ],
          ),
        ),
        Gap(10.h),
        _InfoGroup(rows: rows),
      ],
    );
  }
}

class _InfoRow {
  const _InfoRow(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String? value;
}

class _InfoGroup extends StatelessWidget {
  const _InfoGroup({required this.rows});
  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final preset = AppAccent.presets[state.colorIndex];
        final accent = isDark ? preset.dark : preset.light;
        final borderColor = accent.withValues(alpha: isDark ? 0.40 : 0.30);
        final dividerColor = accent.withValues(alpha: isDark ? 0.22 : 0.18);
        final badgeColor = accent.withValues(alpha: isDark ? 0.18 : 0.12);

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppAccent.cardBg(context),
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21.r),
            child: Column(
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  if (i != 0)
                    Divider(height: 1, thickness: 1, color: dividerColor),
                  _InfoTile(row: rows[i], badgeColor: badgeColor),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.row, required this.badgeColor});
  final _InfoRow row;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: badgeColor,
            ),
            child: Icon(
              row.icon,
              size: 18.sp,
              color: AppAccent.primaryText(context),
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  row.label,
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    color: AppAccent.secoundaryText(context),
                  ),
                ),
                Gap(2.h),
                Text(
                  row.value!,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: GoogleFonts.dmSans(
                    fontSize: 16.sp,
                    fontWeight: .w500,
                    color: AppAccent.primaryText(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
