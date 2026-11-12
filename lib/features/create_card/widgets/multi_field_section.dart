import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/create_card/cubit/multi_field_cubit.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiFieldSection extends StatelessWidget {
  const MultiFieldSection({
    super.key,
    required this.title,
    required this.hint,
    required this.addLabel,
    required this.onChanged,
    this.initialValues = const [],
    this.max = 3,
    this.keyboardType,
  });

  final String title;
  final String hint;
  final String addLabel;
  final int max;
  final TextInputType? keyboardType;
  final List<String> initialValues;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MultiFieldCubit(
        max: max,
        onChanged: onChanged,
        initial: initialValues,
      ),
      child: _View(
        title: title,
        hint: hint,
        addLabel: addLabel,
        keyboardType: keyboardType,
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View({
    required this.title,
    required this.hint,
    required this.addLabel,
    this.keyboardType,
  });

  final String title;
  final String hint;
  final String addLabel;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<MultiFieldCubit>();

    return BlocBuilder<MultiFieldCubit, MultiFieldState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${state.count} of ${cubit.max}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            Gap(8.h),
            for (var i = 0; i < state.count; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  key: ObjectKey(state.controllers[i]),
                  children: [
                    Expanded(
                      child: TextField(
                        controller: state.controllers[i],
                        keyboardType: keyboardType,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        cursorColor: Color.lerp(
                          const Color(0xFFD8D2C3),
                          Colors.black,
                          0.2,
                        )!,
                        cursorErrorColor: Colors.red,
                        enableInteractiveSelection: false,
                        style: GoogleFonts.dmSans(
                          fontSize: 16.sp,
                          color: AppAccent.primaryText[0],
                        ),
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: GoogleFonts.dmSans(
                            color: const Color(0xFF757575),
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    Gap(10.w),
                    IconButton.filledTonal(
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFEAE5D8),
                      ),
                      color: AppAccent.primaryText[0],
                      tooltip: 'Remove',
                      onPressed: () => cubit.remove(i),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            if (cubit.canAdd)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  overlayColor: Colors.black.withValues(alpha: 0.01),
                  foregroundColor: AppAccent.primaryText[0],
                ),
                onPressed: cubit.add,
                child: Text(
                  '+ $addLabel',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
