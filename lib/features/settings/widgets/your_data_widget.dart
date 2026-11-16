import 'package:business_card/core/components/../constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/backup_service.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:business_card/features/main_layout/cubit/cards_cubit.dart';
import 'package:business_card/features/settings/widgets/settings_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';

class YourDataWidget extends StatefulWidget {
  const YourDataWidget({super.key});

  @override
  State<YourDataWidget> createState() => _YourDataWidgetState();
}

class _YourDataWidgetState extends State<YourDataWidget> {
  bool _busy = false;

  Future<void> _run(
    Future<BackupResult> Function(CardsCubit) action,
    bool isBackup,
  ) async {
    if (_busy) return;
    final cubit = context.read<CardsCubit>();
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);

    final result = await action(cubit);

    if (mounted) setState(() => _busy = false);

    String text;
    SnackBarAction? snackAction;
    switch (result.status) {
      case BackupStatus.ok:
        text = isBackup
            ? 'Backup saved to Downloads (${result.count} cards)'
            : 'Restored ${result.count} cards';
      case BackupStatus.noPermission:
        text = 'Allow access to all files to use backups';
        snackAction = const SnackBarAction(
          label: 'Settings',
          onPressed: openAppSettings,
        );
      case BackupStatus.notFound:
        text = 'No backup found in Downloads';
      case BackupStatus.invalid:
        text = 'The backup file is not valid';
      case BackupStatus.failed:
        text = isBackup ? 'Could not create the backup' : 'Could not restore';
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text), action: snackAction));
  }

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      text: 'YOUR DATA',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21.r),
        child: Column(
          children: [
            const _Header(),
            Divider(height: 1, color: AppAccent.stroke(context)),
            _ActionRow(
              label: 'Back up your cards',
              busy: _busy,
              onTap: () => _run((c) => c.backup(), true),
            ),
            Divider(height: 1, color: AppAccent.stroke(context)),
            _ActionRow(
              label: 'Restore from a backup',
              busy: _busy,
              onTap: () => _run((c) => c.restore(), false),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final preset = AppAccent.presets[state.colorIndex];
              return Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.isDark ? preset.dark : preset.light,
                ),
                child: Icon(
                  Iconsax.lock,
                  size: 22.sp,
                  color: AppAccent.primaryText3(context),
                ),
              );
            },
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Everything stays on this device',
                  style: GoogleFonts.dmSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppAccent.primaryText(context),
                  ),
                ),
                Gap(2.h),
                Text(
                  'No account and no servers',
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
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.label,
    required this.busy,
    required this.onTap,
  });

  final String label;
  final bool busy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: busy ? null : onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.dmSans(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: AppAccent.primaryText(context),
                  ),
                ),
              ),
              if (busy)
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  size: 24.sp,
                  color: AppAccent.primaryText(context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
