import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class NoCardsWidget extends StatelessWidget {
  const NoCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Column(
        children: [
          Gap(32.h),
          const _NoCardsStack(),
          Gap(45.h),
          Text(
            'Make your first card',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 28.sp,
              fontWeight: .w700,
              letterSpacing: -0.56,
              color: const Color(0xFF15171A),
            ),
          ),
          Gap(9.37.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              'Add your details once, then share them with a QR code or a link. No account needed.',
              textAlign: .center,
              style: GoogleFonts.dmSans(
                color: const Color(0xFF5F636A),
                fontSize: 15.sp,
                fontWeight: .normal,
              ),
            ),
          ),
          Gap(28.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                  color: Colors.black.withValues(alpha: 0.1),
                ),
              ],
            ),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 56.h),
              ),
              onPressed: () {},
              label: const Text('Create a card'),
              icon: Icon(Icons.add, size: 22.sp),
            ),
          ),
          Gap(14.h),
          Row(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Icon(Iconsax.lock, color: const Color(0xFF5F636A), size: 12.sp),
              Gap(6.w),
              Text(
                'Saved only on this device',
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF5F636A),
                  fontSize: 12.sp,
                  fontWeight: .normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NoCardsStack extends StatelessWidget {
  const _NoCardsStack();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        _Card(
          width: 250.w,
          height: 150.h,
          border: Border.all(
            color: const Color(0xFFDDD7C8).withValues(alpha: 0.6),
          ),
          color: const Color(0xFFE5E1D8).withValues(alpha: 0.6),
          angel: -6,
          shadow: [
            BoxShadow(
              color: const Color(0xFF000000).withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),

        _Card(
          width: 240.w,
          height: 140.h,
          border: Border.all(
            color: const Color(0xFFDDD7C8).withValues(alpha: 0.8),
          ),
          color: const Color(0xFFEAE5D8).withValues(alpha: 0.8),
          angel: 3,
          shadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: const Color(0xFF000000).withValues(alpha: 0.05),
              blurRadius: 2,
            ),
          ],
        ),

        const _EmptyCardWidget(),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.border,
    required this.color,
    required this.angel,
    required this.height,
    required this.width,
    this.shadow,
  });
  final double height;
  final double width;
  final Color color;
  final Border border;
  final double angel;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angel * math.pi / 180,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          border: border,
          boxShadow: shadow,
        ),
      ),
    );
  }
}

class _EmptyCardWidget extends StatelessWidget {
  const _EmptyCardWidget();

  static const double _radius = 22;
  static const Color _stroke = Color(0x665F636A);
  static const Color _fill = Color(0xB3FFFFFF);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(_radius);

    return Container(
      width: 250.w,
      height: 148.h,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: CustomPaint(
            foregroundPainter: _DashedRRectPainter(
              color: _stroke,
              strokeWidth: 2,
              radius: _radius,
              dash: 6,
              gap: 4,
            ),
            child: Container(
              color: _fill,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF15171A).withValues(alpha: 0.05),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 24,
                      color: Color(0xFF15171A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your first card goes here',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF5F636A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.dash,
    required this.gap,
  });

  final Color color;
  final double strokeWidth;
  final double radius;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final inset = strokeWidth / 2;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        inset,
        inset,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius - inset),
    );

    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dash).clamp(0, metric.length).toDouble();
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.radius != radius ||
      old.dash != dash ||
      old.gap != gap;
}
