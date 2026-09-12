import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/constants/app_sizes.dart';
import 'package:business_card/core/resources/app_assets.dart';
import 'package:business_card/core/styles/app_text_styles.dart';
import 'package:business_card/features/splash/widgets/linear_sliding_roller.dart';
import 'package:business_card/features/splash/widgets/three_dots_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                AppAssets.appIcon,
                width: AppSizes.width64,
                height: AppSizes.height64,
              ),
              Gap(AppSizes.height15),
              Text('Card', style: AppTextStyles.splash),
              const Spacer(),
              const ThreeDotsLoader(),
              Gap(AppSizes.height16),
              const LinearSlidingLoader(),
              Gap(AppSizes.height80),
            ],
          ),
        ),
      ),
    );
  }
}
