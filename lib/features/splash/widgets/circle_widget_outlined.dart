import 'package:material_ui/material_ui.dart';

class CircleWidgetOutlined extends StatelessWidget {
  const CircleWidgetOutlined({super.key, required this.radius});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: .circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
    );
  }
}
