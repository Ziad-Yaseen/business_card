import 'package:business_card/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCardView extends StatelessWidget {
  const CreateCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [_CreateCardAppBar(), Gap(12.h), _CardPreview()],
        ),
      ),
    );
  }
}

class _CreateCardAppBar extends StatelessWidget {
  const _CreateCardAppBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      right: false,
      left: false,
      child: Row(
        children: [
          const _BackButton(),
          Gap(12.w),
          Text(
            'New Card',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24.sp,
              fontWeight: .w700,
              letterSpacing: -0.6,
              color: AppAccent.primaryText[0],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: GoogleFonts.dmSans(fontSize: 15.sp, fontWeight: .w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: .circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(9999),
            side: const BorderSide(color: Color(0xFFD8D2C3)),
          ),
        ),
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }
}

class _CardPreview extends StatelessWidget {
  const _CardPreview();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
