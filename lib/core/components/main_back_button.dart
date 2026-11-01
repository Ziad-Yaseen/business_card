import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: .circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(9999),
            side: const BorderSide(color: Color(0xFFD8D2C3)),
          ),
        ),
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }
}
