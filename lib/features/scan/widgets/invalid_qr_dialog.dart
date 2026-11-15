import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/helpers/theme_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

Future<void> showInvalidQrDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Not a card QR code'),
      content: const Text(
        "This QR code isn't a card made with this app. "
        'Ask the owner to share their card QR code and scan it again.',
      ),
      actions: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (_, state) => TextButton(
            style: TextButton.styleFrom(
              backgroundColor: context.isDark
                  ? AppAccent.presets[state.colorIndex].dark
                  : AppAccent.presets[state.colorIndex].light,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try again'),
          ),
        ),
      ],
    ),
  );
}
