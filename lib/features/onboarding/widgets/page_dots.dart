import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.controller, required this.count});

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    final secoundary = AppAccent.secondaryDot(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final ready =
            controller.hasClients && controller.position.haveDimensions;
        final page = ready ? (controller.page ?? 0.0) : 0.0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (i) {
            final t = (1 - (page - i).abs()).clamp(0.0, 1.0).toDouble();
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (_, state) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 8.w + 20.w * t,
                height: 8.w,
                decoration: BoxDecoration(
                  color: Color.lerp(
                    secoundary,
                    context.isDark
                        ? AppAccent.presets[state.colorIndex].dark
                        : AppAccent.presets[state.colorIndex].light,
                    t,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
