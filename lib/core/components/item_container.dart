import 'package:business_card/core/constants/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: .circle,
        color: AppAccent.cardBg(context),
        border: Border.all(color: AppAccent.border(context), width: 1),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 2,
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: child,
    );
  }
}
