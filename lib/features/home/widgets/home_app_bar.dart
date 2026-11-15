import 'package:business_card/core/components/item_container.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/routes/route_names.dart';
import 'package:business_card/core/styles/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.numberOfCards});
  final int numberOfCards;

  @override
  Widget build(BuildContext context) {
    const String title = 'My cards';
    final String cards = numberOfCards == 0
        ? 'Nothing here yet'
        : '$numberOfCards cards · saved on this device';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(title, style: AppTextStyles.appbarTitle(context)),
                // Gap(8.h),
                Text(
                  cards,
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: .normal,
                    letterSpacing: -0.38,
                    color: AppAccent.secoundaryText(context),
                  ),
                ),
              ],
            ),
            ItemContainer(
              child: IconButton(
                tooltip: 'Settings',
                icon: Icon(
                  Iconsax.setting_4,
                  color: AppAccent.primaryText(context),
                ),
                onPressed: () {
                  context.pushNamed(RouteNames.settings);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
