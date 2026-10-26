import 'dart:math';

import 'package:flutter/material.dart';

class _T {
  static const double w = 342;
  static const double h = 384;

  static const Color ink = Color(0xFF15171A);

  static const double cardW = 210;
  static const double cardH = 128;
  static const double cardR = 20;
}

class CardThree extends StatelessWidget {
  const CardThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.contain,
        child: ClipRect(
          child: SizedBox(
            width: _T.w,
            height: _T.h,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _FannedCard(
                  centerX: 96.6,
                  centerY: 165.1,
                  angleDeg: -20,
                  colors: [Color(0xFF2A55E0), Color(0xFF1636A0)],
                ),
                _FannedCard(
                  centerX: 245.4,
                  centerY: 165.1,
                  angleDeg: 20,
                  colors: [Color(0xFF2C8461), Color(0xFF17543D)],
                ),

                Positioned(left: 66, top: 92, child: _FrontCard()),

                Positioned(
                  left: 0,
                  right: 0,
                  top: 290,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Pill('Work'),
                      SizedBox(width: 10),
                      _Pill('Freelance'),
                      SizedBox(width: 10),
                      _Pill('Personal'),
                    ],
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

class _FannedCard extends StatelessWidget {
  const _FannedCard({
    required this.centerX,
    required this.centerY,
    required this.angleDeg,
    required this.colors,
  });

  final double centerX;
  final double centerY;
  final double angleDeg;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: centerX - _T.cardW / 2,
      top: centerY - _T.cardH / 2,
      child: Transform.rotate(
        angle: angleDeg * pi / 180,
        child: Container(
          width: _T.cardW,
          height: _T.cardH,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_T.cardR),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            boxShadow: [
              BoxShadow(
                color: _T.ink.withValues(alpha: .22),
                offset: const Offset(0, 10),
                blurRadius: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrontCard extends StatelessWidget {
  const _FrontCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _T.cardW,
      height: _T.cardH,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_T.cardR),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEFE4CB), Color(0xFFE0CFA9)],
        ),
        boxShadow: [
          BoxShadow(
            color: _T.ink.withValues(alpha: .26),
            offset: const Offset(0, 14),
            blurRadius: 28,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 18,
            top: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 96,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _T.ink,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 9),
                Container(
                  width: 64,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _T.ink.withValues(alpha: .45),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 14,
            bottom: 12,
            child: CustomPaint(
              size: const Size(46, 46),
              painter: _MiniQrPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _T.ink.withValues(alpha: .10),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: _T.ink,
          fontSize: 14,
          height: 17 / 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MiniQrPainter extends CustomPainter {
  static const int n = 21;

  @override
  void paint(Canvas canvas, Size size) {
    final m = size.width / n;
    final ink = Paint()..color = _T.ink;
    final bg = Paint()..color = const Color(0xFFE9DBBB);

    bool inFinderZone(int r, int c) =>
        (r < 8 && c < 8) || (r < 8 && c >= n - 8) || (r >= n - 8 && c < 8);

    final rnd = Random(3);
    for (var r = 0; r < n; r++) {
      var start = -1;
      for (var c = 0; c <= n; c++) {
        final on = c < n && !inFinderZone(r, c) && rnd.nextDouble() < 0.55;
        if (on && start < 0) start = c;
        if (!on && start >= 0) {
          canvas.drawRect(
            Rect.fromLTWH(start * m, r * m, (c - start) * m, m),
            ink,
          );
          start = -1;
        }
      }
    }

    void finder(int r, int c) {
      final x = c * m, y = r * m;
      canvas.drawRect(Rect.fromLTWH(x, y, 7 * m, 7 * m), ink);
      canvas.drawRect(Rect.fromLTWH(x + m, y + m, 5 * m, 5 * m), bg);
      canvas.drawRect(Rect.fromLTWH(x + 2 * m, y + 2 * m, 3 * m, 3 * m), ink);
    }

    finder(0, 0);
    finder(0, n - 7);
    finder(n - 7, 0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
