import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/core/components/card_preview.dart';
import 'package:business_card/core/routes/route_names.dart';
import 'package:business_card/features/onboarding/widgets/page_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CardsViewWidget extends StatefulWidget {
  const CardsViewWidget({super.key});

  @override
  State<CardsViewWidget> createState() => _CardsViewWidgetState();
}

class _CardsViewWidgetState extends State<CardsViewWidget> {
  final PageController _controller = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _data = ['fsdfsdfsd', 'fsdf', '', '', '', '', '', '', '', ''];
    return Column(
      children: [
        Gap(26.h),
        SizedBox(
          width: double.infinity,
          child: CardsCarousel(
            controller: _controller,
            itemCount: _data.length,
            itemBuilder: (context, i) =>
                const CardPreview(pattern: CardPattern.rings, addSpacer: true),
            onCardTap: (i) {},
          ),
        ),
        Gap(20.h),
        PageDots(controller: _controller, count: _data.length),
        Gap(26.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: _NewCardButton(
            onTap: () {
              context.push(RouteNames.create);
            },
          ),
        ),
        Gap(24.h),
      ],
    );
  }
}

class _NewCardButton extends StatelessWidget {
  const _NewCardButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = 18.r;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedBorderPainter(color: scheme.outline, radius: radius),
          child: SizedBox(
            height: 56.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: scheme.onSurface),
                Gap(10.w),
                Text(
                  'New card',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  static const _dash = 7.0;
  static const _gap = 6.0;
  static const _stroke = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(_stroke / 2);
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke;

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + _dash), paint);
        distance += _dash + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color || old.radius != radius;
}

class CardsCarousel extends StatelessWidget {
  const CardsCarousel({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
    this.onCardTap,
    this.height = 272,
  });

  final PageController controller;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ValueChanged<int>? onCardTap;

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: OverflowBox(
        maxHeight: height.h + 60.h,
        minHeight: height.h + 60.h,
        child: PageView.builder(
          controller: controller,
          itemCount: itemCount,
          padEnds: false,
          // clipBehavior: Clip.,
          itemBuilder: (context, i) => _CarouselItem(
            index: i,
            controller: controller,
            onTap: onCardTap == null ? null : () => onCardTap!(i),
            child: itemBuilder(context, i),
          ),
        ),
      ),
    );
  }
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({
    required this.index,
    required this.controller,
    required this.child,
    this.onTap,
  });

  final int index;
  final PageController controller;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 30.h,
          bottom: 30.h,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(width: double.infinity, child: child),
          ),
        ),
      ),
      builder: (context, child) {
        final ready =
            controller.hasClients && controller.position.haveDimensions;
        final page = ready ? (controller.page ?? 0.0) : 0.0;

        final d = (page - index).abs().clamp(0.0, 1.0).toDouble();

        return Opacity(
          opacity: 1 - 0.3 * d,
          child: Transform.scale(
            scale: 1 - 0.12 * d,
            alignment: Alignment.centerLeft,
            child: child,
          ),
        );
      },
    );
  }
}
