import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanBannerWidget extends StatelessWidget {
  const ScanBannerWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  static const double _radius = 18;
  static const Color _stroke = Color(0xFFC7C2B6);
  static const Color _fill = Color(0xFFEFECE4);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(_radius.r);

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CustomPaint(
          foregroundPainter: _BannerDashedPainter(
            color: _stroke,
            strokeWidth: 1.5,
            radius: _radius.r,
            dash: 6,
            gap: 4,
          ),
          child: Container(
            color: _fill,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.qr_code_2_rounded,
                  size: 26.sp,
                  color: const Color(0xFF5F636A),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Scan someone's QR code to keep their card here. Call, email or open their links in one tap.",
                    style: GoogleFonts.dmSans(
                      fontSize: 12.5.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5F636A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerDashedPainter extends CustomPainter {
  _BannerDashedPainter({
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
  bool shouldRepaint(covariant _BannerDashedPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.radius != radius ||
      old.dash != dash ||
      old.gap != gap;
}
