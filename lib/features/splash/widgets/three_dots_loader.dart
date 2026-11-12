import 'package:business_card/core/constants/app_sizes.dart';
import 'package:material_ui/material_ui.dart';

import 'dart:math' as math;

class ThreeDotsLoader extends StatefulWidget {
  const ThreeDotsLoader({super.key});

  @override
  State createState() => _ThreeDotsLoaderState();
}

class _ThreeDotsLoaderState extends State with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double val = math.sin(
          (_controller.value * math.pi * 2) - (index * math.pi / 2.5),
        );
        final double normalized = (val + 1) / 2;

        return Transform.scale(
          scale: 0.6 + (normalized * 0.4),
          child: Opacity(opacity: 0.3 + (normalized * 0.7), child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: AppSizes.width6,
        height: AppSizes.height6,
        decoration: const BoxDecoration(
          color: Color(0xFFD6D6D6),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) => _buildDot(index)),
    );
  }
}
