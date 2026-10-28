import 'package:business_card/core/components/item_container.dart';
import 'package:business_card/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
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
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(title, style: AppTextStyles.appbarTItle(true)),
              // Gap(8.h),
              Text(
                cards,
                style: GoogleFonts.dmSans(
                  fontSize: 15.sp,
                  fontWeight: .normal,
                  letterSpacing: -0.38,
                  color: const Color(0xFF5F636A),
                ),
              ),
            ],
          ),
          const ItemContainer(child: Icon(Iconsax.setting_4)),
        ],
      ),
    );
  }
}
