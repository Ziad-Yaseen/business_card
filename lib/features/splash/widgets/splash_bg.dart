import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/splash/widgets/circle_widget_outlined.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashBG extends StatelessWidget {
  const SplashBG({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppAccent.splashBg,
      body: Center(
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Stack(
            alignment: .center,
            clipBehavior: .none,
            children: [
              CircleWidgetOutlined(radius: 140.w),
              CircleWidgetOutlined(radius: 280.w),
              CircleWidgetOutlined(radius: 440.w),
              CircleWidgetOutlined(radius: 620.w),
              CircleWidgetOutlined(radius: 820.w),
              CircleWidgetOutlined(radius: 1040.w),
              SizedBox(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
