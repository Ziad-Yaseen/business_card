import 'package:business_card/core/components/item_container.dart';
import 'package:business_card/core/components/main_back_button.dart';
import 'package:business_card/core/components/main_card_preview.dart';
import 'package:business_card/data/models/card_model.dart';
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
            children: [Gap(8.h), const _PreviewAppBar(), Gap(10.h),
            MainCardPreview(card: card)
            ],
          ),
        ),
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
