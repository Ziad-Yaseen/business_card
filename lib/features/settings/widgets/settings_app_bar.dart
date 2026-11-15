import 'package:business_card/core/components/main_back_button.dart';
import 'package:business_card/core/styles/app_text_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .start,
      children: [
        const MainBackButton(),
        Gap(14.w),
        Text('Settings', style: AppTextStyles.appbarTItle(true)),
      ],
    );
  }
}
