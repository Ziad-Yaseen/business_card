import 'package:business_card/core/components/item_container.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
      child: IconButton(
        tooltip: 'Back',
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios_new_outlined),
      ),
    );
  }
}
