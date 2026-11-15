import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/settings/widgets/settings_item_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, this.text = 'Item', required this.child});
  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: .centerStart,
          child: Text(
            text.toUpperCase(),
            style: GoogleFonts.dmSans(
              fontSize: 13.sp,
              fontWeight: .w600,
              letterSpacing: 1.04,
              color: AppAccent.secoundaryText(context),
            ),
          ),
        ),
        Gap(10.h),
        SettingsItemContainer(child: child),
      ],
    );
  }
}
