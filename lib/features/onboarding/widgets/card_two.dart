import 'dart:math';

import 'package:material_ui/material_ui.dart';

const double _kW = 342;
const double _kH = 384;

const Color _ink = Color(0xFF15171A);
const Color _scanRed = Color(0xFFD63A10);
const Color _pill = Color(0xFFE2DDD0);

class CardTwo extends StatelessWidget {
  const CardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: _kW,
          height: _kH,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Positioned(
                left: 56,
                top: 34,
                child: _Bracket(top: true, left: true),
              ),
              const Positioned(
                right: 56,
                top: 34,
                child: _Bracket(top: true, left: false),
              ),
              const Positioned(
                left: 56,
                bottom: 34,
                child: _Bracket(top: false, left: true),
              ),
              const Positioned(
                right: 56,
                bottom: 34,
                child: _Bracket(top: false, left: false),
              ),

              const Positioned(left: 94, top: 54, child: _Phone()),

              Positioned(
                left: 70,
                top: 196,
                child: Container(
                  width: 202,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _scanRed,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: _scanRed.withValues(alpha: .55),
                        blurRadius: 14,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: _scanRed.withValues(alpha: .25),
                        blurRadius: 30,
                        spreadRadius: 6,
                      ),
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

class _Phone extends StatelessWidget {
  const _Phone();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 276,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _ink,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: _ink.withValues(alpha: .28),
            offset: const Offset(0, 18),
            blurRadius: 34,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(size: const Size(96, 96), painter: _QrPainter()),
            const SizedBox(height: 14),
            Container(
              width: 70,
              height: 8,
              decoration: BoxDecoration(
                color: _pill,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  static const int n = 25;

  @override
  void paint(Canvas canvas, Size size) {
    final m = size.width / n;
    final paint = Paint()
      ..color = _ink
      ..isAntiAlias = false;
    final white = Paint()..color = Colors.white;

    bool inFinderZone(int r, int c) =>
        (r < 8 && c < 8) || (r < 8 && c >= n - 8) || (r >= n - 8 && c < 8);

    final rnd = Random(7);
    for (var r = 0; r < n; r++) {
      var runStart = -1;
      for (var c = 0; c <= n; c++) {
        final on = c < n && !inFinderZone(r, c) && rnd.nextDouble() < 0.5;
        if (on && runStart < 0) runStart = c;
        if (!on && runStart >= 0) {
          canvas.drawRect(
            Rect.fromLTWH(runStart * m, r * m, (c - runStart) * m, m),
            paint,
          );
          runStart = -1;
        }
      }
    }

    // Finder patterns
    void finder(int r, int c) {
      final x = c * m, y = r * m;
      canvas.drawRect(Rect.fromLTWH(x, y, 7 * m, 7 * m), paint);
      canvas.drawRect(Rect.fromLTWH(x + m, y + m, 5 * m, 5 * m), white);
      canvas.drawRect(Rect.fromLTWH(x + 2 * m, y + 2 * m, 3 * m, 3 * m), paint);
    }

    finder(0, 0);
    finder(0, n - 7);
    finder(n - 7, 0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Bracket extends StatelessWidget {
  const _Bracket({required this.top, required this.left});

  final bool top;
  final bool left;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(36, 36),
      painter: _BracketPainter(top: top, left: left),
    );
  }
}

class _BracketPainter extends CustomPainter {
  _BracketPainter({required this.top, required this.left});

  final bool top;
  final bool left;

  static const double _outerR = 18;
  static const double _thick = 5;
  static const double _thin = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    Radius r(bool isRounded, double v) =>
        isRounded ? Radius.circular(v) : Radius.zero;

    final outer = RRect.fromRectAndCorners(
      rect,
      topLeft: r(top && left, _outerR),
      topRight: r(top && !left, _outerR),
      bottomLeft: r(!top && left, _outerR),
      bottomRight: r(!top && !left, _outerR),
    );

    final l = left ? _thick : _thin;
    final rt = left ? _thin : _thick;
    final t = top ? _thick : _thin;
    final b = top ? _thin : _thick;

    final innerRect = Rect.fromLTRB(l, t, size.width - rt, size.height - b);
    const innerR = _outerR - _thick;
    final inner = RRect.fromRectAndCorners(
      innerRect,
      topLeft: r(top && left, innerR),
      topRight: r(top && !left, innerR),
      bottomLeft: r(!top && left, innerR),
      bottomRight: r(!top && !left, innerR),
    );

    canvas.drawDRRect(outer, inner, Paint()..color = _ink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
