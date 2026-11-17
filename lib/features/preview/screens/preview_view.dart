import 'package:business_card/core/components/item_container.dart';
import 'package:business_card/core/components/main_back_button.dart';
import 'package:business_card/core/components/main_card_preview.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/card_share.dart';
import 'package:business_card/core/helpers/qr_image_service.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/core/routes/route_names.dart';
import 'package:business_card/data/models/card_model.dart';
import 'package:business_card/features/main_layout/cubit/cards_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

enum _CardMenu { duplicate, delete }

class PreviewView extends StatefulWidget {
  const PreviewView({super.key, required this.card});
  final CardModel card;

  @override
  State<PreviewView> createState() => _PreviewViewState();
}

class _PreviewViewState extends State<PreviewView> {
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
    final bytes = await QrImageService.render(link);
    await SharePlus.instance.share(
      ShareParams(
        text: link,
        subject: _card.fullName,
        files: bytes == null
            ? null
            : [XFile.fromData(bytes, mimeType: 'image/png')],
        fileNameOverrides: bytes == null
            ? null
            : [QrImageService.fileName(_card.fullName)],
      ),
    );
  }

  Future<void> _saveQr(String link) async {
    final result = await QrImageService.save(link, _card.fullName);
    if (!mounted) return;
    switch (result.status) {
      case QrSaveStatus.ok:
        _snack('Saved to cards/my cards');
      case QrSaveStatus.noPermission:
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Allow access to all files to save the QR'),
              action: SnackBarAction(
                label: 'Settings',
                onPressed: openAppSettings,
              ),
            ),
          );
      case QrSaveStatus.failed:
        _snack('Could not save the QR');
    }
  }

  Future<void> _open(Uri uri) async {
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && mounted) _snack('Could not open it');
    } catch (_) {
      if (mounted) _snack('Could not open it');
    }
  }

  Future<void> _edit() async {
    final cubit = context.read<CardsCubit>();
    final saved = await context.push<bool>(RouteNames.create, extra: _card);
    if (saved != true || !mounted) return;
    final fresh = await cubit.byId(_card.id);
    if (fresh == null || !mounted) return;
    setState(() => _card = fresh);
  }

  Future<void> _duplicate() async {
    final cubit = context.read<CardsCubit>();
    try {
      await cubit.duplicate(_card);
      if (!mounted) return;
      _snack('Card duplicated');
    } catch (_) {
      if (!mounted) return;
      _snack('Could not duplicate the card');
    }
  }

  Future<void> _delete() async {
    final cubit = context.read<CardsCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete this card?'),
        content: const Text('This can’t be undone.'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.transparent),
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),

          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) => TextButton(
              style: TextButton.styleFrom(
                backgroundColor: context.isDark
                    ? AppAccent.presets[state.colorIndex].dark
                    : AppAccent.presets[state.colorIndex].light,
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Delete'),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await cubit.delete(_card.id);
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
        child: Column(
          children: [
            Gap(8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: _PreviewAppBar(
                isMine: _card.mine,
                onEdit: _edit,
                onMenu: _onMenu,
              ),
            ),
            Gap(10.h),
            Expanded(
              child: ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (rect) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [Colors.transparent, Colors.black],
                  stops: [0.0, (14.h / rect.height).clamp(0.0, 1.0)],
                ).createShader(rect),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(24.0.w, 14.h, 24.0.w, 0),
                  child: Column(
                    children: [
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
                      _InThisCard(card: _card, onOpen: _open),
                      Gap(24.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
  const _PreviewAppBar({
    required this.isMine,
    required this.onEdit,
    required this.onMenu,
  });
  final bool isMine;
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
        if (isMine) ...[
          ItemContainer(
            child: IconButton(
              tooltip: 'Edit',
              icon: const Icon(Iconsax.edit_2),
              onPressed: onEdit,
            ),
          ),
          Gap(12.w),
        ],
        ItemContainer(
          child: PopupMenuButton<_CardMenu>(
            icon: const Icon(Iconsax.more),
            onSelected: onMenu,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            itemBuilder: (_) => [
              if (isMine)
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
              tooltip: 'Copy',
              style: IconButton.styleFrom(
                overlayColor: context.isDark
                    ? AppAccent.presets[state.colorIndex].dark.withValues(
                        alpha: 0.05,
                      )
                    : AppAccent.presets[state.colorIndex].light.withValues(
                        alpha: 0.05,
                      ),
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

Uri? _webUri(String? raw, String base) {
  var v = (raw ?? '').trim();
  if (v.isEmpty) return null;
  if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9+.\-]*://').hasMatch(v)) {
    final handle = v.startsWith('@') ? v.substring(1) : v;
    final looksLikeHandle =
        v.startsWith('@') || (!v.contains('.') && !v.contains('/'));
    v = looksLikeHandle ? '$base$handle' : 'https://$v';
  }
  final uri = Uri.tryParse(v);
  if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
    return null;
  }
  return uri;
}

class _InThisCard extends StatelessWidget {
  const _InThisCard({required this.card, required this.onOpen});
  final CardModel card;
  final ValueChanged<Uri> onOpen;

  @override
  Widget build(BuildContext context) {
    final rows = <_InfoRow>[
      for (final e in card.email)
        _InfoRow(
          Iconsax.sms,
          'Email',
          e,
          Uri(scheme: 'mailto', path: e.trim()),
        ),
      for (final p in card.phone)
        _InfoRow(
          Iconsax.call,
          'Phone',
          p,
          Uri(scheme: 'tel', path: p.replaceAll(RegExp(r'[^\d+]'), '')),
        ),
      _InfoRow(
        Iconsax.link_2,
        'LinkedIn',
        card.linkedIn,
        _webUri(card.linkedIn, 'https://www.linkedin.com/in/'),
      ),
      _InfoRow(
        Iconsax.link_2,
        'GitHub',
        card.github,
        _webUri(card.github, 'https://github.com/'),
      ),
      _InfoRow(
        Iconsax.link_2,
        'Portfolio',
        card.portfolio,
        _webUri(card.portfolio, 'https://'),
      ),
      _InfoRow(
        Iconsax.link_2,
        'Instagram',
        card.instagram,
        _webUri(card.instagram, 'https://www.instagram.com/'),
      ),
      _InfoRow(
        Iconsax.link_2,
        'Facebook',
        card.facebook,
        _webUri(card.facebook, 'https://www.facebook.com/'),
      ),
      _InfoRow(Iconsax.link_2, 'X', card.x, _webUri(card.x, 'https://x.com/')),
      _InfoRow(
        Iconsax.link_2,
        'TikTok',
        card.tiktok,
        _webUri(card.tiktok, 'https://www.tiktok.com/@'),
      ),
      for (final m in card.more ?? const <String>[])
        _InfoRow(Iconsax.link_2, 'Link', m, _webUri(m, 'https://')),
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
        _InfoGroup(rows: rows, onOpen: onOpen),
      ],
    );
  }
}

class _InfoRow {
  const _InfoRow(this.icon, this.label, this.value, this.uri);
  final IconData icon;
  final String label;
  final String? value;

  final Uri? uri;
}

class _InfoGroup extends StatelessWidget {
  const _InfoGroup({required this.rows, required this.onOpen});
  final List<_InfoRow> rows;
  final ValueChanged<Uri> onOpen;

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
                  _InfoTile(
                    row: rows[i],
                    badgeColor: badgeColor,
                    onOpen: onOpen,
                  ),
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
  const _InfoTile({
    required this.row,
    required this.badgeColor,
    required this.onOpen,
  });
  final _InfoRow row;
  final Color badgeColor;
  final ValueChanged<Uri> onOpen;

  @override
  Widget build(BuildContext context) {
    final uri = row.uri;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: uri == null ? null : () => onOpen(uri),
        child: Padding(
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
        ),
      ),
    );
  }
}
