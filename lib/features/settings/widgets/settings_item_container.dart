import 'package:business_card/core/constants/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItemContainer extends StatelessWidget {
  const SettingsItemContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppAccent.cardBg(context),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppAccent.stroke(context), width: 1),
      ),
      child: child,
    );
  }
}
