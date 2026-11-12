import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;

  final bool isPrimary;
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _barColor = Color(0xFF15171A);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: Container(
          height: 72.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: _barColor,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.28),
                blurRadius: 30,
                offset: const Offset(0, 14),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < items.length; i++) ...[
                if (i != 0) Gap(8.w),
                items[i].isPrimary
                    ? _PrimaryButton(item: items[i], onTap: () => onTap(i))
                    : _NavItemWidget(
                        isActive: i == currentIndex,
                        item: items[i],
                        onTap: () => onTap(i),
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.item, required this.onTap});

  final AppBottomNavItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 52.h,
        height: 52.h,
        decoration: const BoxDecoration(
          color: Color(0xFFD93A10),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(item.icon, size: 22, color: Colors.white),
      ),
    );
  }
}

class _NavItemWidget extends StatelessWidget {
  const _NavItemWidget({
    required this.isActive,
    required this.item,
    required this.onTap,
  });

  final AppBottomNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: _duration,
        curve: _curve,
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: isActive ? 0.14 : 0.0),
          borderRadius: BorderRadius.circular(9999),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<Color?>(
              duration: _duration,
              curve: _curve,
              tween: ColorTween(
                end: isActive ? Colors.white : const Color(0xFFD3D6DB),
              ),
              builder: (context, color, _) =>
                  Icon(item.icon, size: 22, color: color),
            ),
            AnimatedSize(
              duration: _duration,
              curve: _curve,
              alignment: Alignment.centerLeft,
              child: isActive
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gap(8.w),
                        AnimatedOpacity(
                          duration: _duration,
                          curve: Curves.easeIn,
                          opacity: isActive ? 1 : 0,
                          child: Text(
                            item.label,
                            maxLines: 1,
                            softWrap: false,
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              height: 21 / 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
