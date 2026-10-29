import 'package:flutter/material.dart';

enum CardPattern { none, rings, stripes }

class CardPatternLayer extends StatelessWidget {
  const CardPatternLayer({
    super.key,
    this.pattern = CardPattern.none,
    this.lineColor = const Color(0x33FFFFFF),
    this.glossColor = const Color(0x40FFFFFF),
  });

  final CardPattern pattern;

  final Color lineColor;

  final Color glossColor;

  @override
  Widget build(BuildContext context) {
    switch (pattern) {
      case CardPattern.none:
        return const SizedBox.shrink();
      case CardPattern.rings:
        return Positioned(
          right: -70,
          bottom: -80,
          width: 240,
          height: 240,
          child: IgnorePointer(child: RingsPattern(color: lineColor)),
        );
      case CardPattern.stripes:
        return Positioned.fill(
          child: IgnorePointer(
            child: StripesPattern(lineColor: lineColor, glossColor: glossColor),
          ),
        );
    }
  }
}

class RingsPattern extends StatelessWidget {
  const RingsPattern({
    super.key,
    this.color = const Color(0x33FFFFFF),
    this.strokeWidth = 1.5,
  });

  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _RingsPainter(color: color, strokeWidth: strokeWidth),
    );
  }
}

class _RingsPainter extends CustomPainter {
  _RingsPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = size.center(Offset.zero);
    final base = size.shortestSide;

    for (final r in const [0.43, 0.29, 0.15]) {
      canvas.drawCircle(center, base * r, paint);
    }
  }

  @override
  bool shouldRepaint(_RingsPainter old) =>
      old.color != color || old.strokeWidth != strokeWidth;
}


class StripesPattern extends StatelessWidget {
  const StripesPattern({
    super.key,
    this.lineColor = const Color(0x33FFFFFF),
    this.glossColor = const Color(0x40FFFFFF),
    this.angle = 0.5,
    this.gap = 26,
  });

  final Color lineColor;
  final Color glossColor;
  final double angle;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _StripesPainter(
        lineColor: lineColor,
        glossColor: glossColor,
        angle: angle,
        gap: gap,
      ),
    );
  }
}

class _StripesPainter extends CustomPainter {
  _StripesPainter({
    required this.lineColor,
    required this.glossColor,
    required this.angle,
    required this.gap,
  });

  final Color lineColor;
  final Color glossColor;
  final double angle;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(angle);

    final reach = size.longestSide * 1.5;

    final bands = <_Band>[
      _Band(-size.width * 0.28, 12),
      _Band(size.width * 0.14, 24),
    ];

    final thin = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    for (double x = -reach; x <= reach; x += gap) {
      final insideBand = bands.any((b) => x > b.x - gap / 2 && x < b.x + b.width + gap / 2);
      if (insideBand) continue;
      canvas.drawLine(Offset(x, -reach), Offset(x, reach), thin);
    }

    for (final b in bands) {
      final rect = Rect.fromLTRB(b.x, -reach, b.x + b.width, reach);

      final fill = Paint()
        ..shader = LinearGradient(
          colors: [
            glossColor.withAlpha(glossColor.alpha ~/ 4),
            glossColor,
            glossColor.withAlpha(glossColor.alpha ~/ 4),
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(rect);
      canvas.drawRect(rect, fill);

      canvas.drawLine(Offset(rect.left, -reach), Offset(rect.left, reach), thin..strokeWidth = 1.5);
      canvas.drawLine(Offset(rect.right, -reach), Offset(rect.right, reach), thin);
    }
  }

  @override
  bool shouldRepaint(_StripesPainter old) =>
      old.lineColor != lineColor ||
      old.glossColor != glossColor ||
      old.angle != angle ||
      old.gap != gap;
}

class _Band {
  const _Band(this.x, this.width);
  final double x;
  final double width;
}