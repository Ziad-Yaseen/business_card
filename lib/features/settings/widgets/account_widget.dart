import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/auth/cubit/auth_cubit.dart';
import 'package:business_card/features/auth/cubit/auth_state.dart';
import 'package:business_card/features/auth/widgets/auth_bottom_sheet.dart';
import 'package:business_card/features/settings/widgets/settings_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_ui/material_ui.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      text: 'ACCOUNT',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21.r),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final divider = Divider(
              height: 1,
              color: AppAccent.stroke(context),
            );

            return AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: state.isLoggedIn
                  ? Column(
                      children: [
                        _EmailRow(email: state.email ?? ''),
                        divider,
                        _ActionRow(
                          label: 'Log out',
                          icon: Iconsax.logout,
                          color: AppAccent.splashBg,
                          onTap: () => context.read<AuthCubit>().signOut(),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _ActionRow(
                          label: 'Create account',
                          onTap: () => showAuthSheet(context, AuthMode.signUp),
                        ),
                        divider,
                        _ActionRow(
                          label: 'Log in',
                          onTap: () => showAuthSheet(context, AuthMode.signIn),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _EmailRow extends StatelessWidget {
  const _EmailRow({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(
            Iconsax.user,
            size: 22.sp,
            color: AppAccent.secoundaryText(context),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Signed in as',
                  style: GoogleFonts.dmSans(
                    fontSize: 13.sp,
                    color: AppAccent.secoundaryText(context),
                  ),
                ),
                Gap(2.h),
                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
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

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.label,
    required this.onTap,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final textColor = color ?? AppAccent.primaryText(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 22.sp, color: textColor),
                Gap(12.w),
              ],
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.dmSans(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              if (color == null)
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
