import 'package:business_card/features/settings/widgets/account_widget.dart';
import 'package:business_card/features/settings/widgets/apperiance_widget.dart';
import 'package:business_card/features/settings/widgets/settings_app_bar.dart';
import 'package:business_card/features/settings/widgets/your_data_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_ui/material_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        left: false,
        right: false,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const SettingsAppBar(),
              Gap(26.h),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const ApperianceWidget(),
                      Gap(24.h),
                      const AccountWidget(),
                      Gap(24.h),
                      const YourDataWidget(),
                      Gap(24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
