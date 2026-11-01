import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/create_card/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'multi_field_section.dart';

class MoreProfilesSection extends StatelessWidget {
  const MoreProfilesSection({
    super.key,
    required this.onChanged,
    required this.onMoreChanged,
    this.initial = const {},
    this.initialMore = const [],
  });

  final ValueChanged<Map<ProfileType, String>> onChanged;
  final ValueChanged<List<String>> onMoreChanged;
  final Map<ProfileType, String> initial;
  final List<String> initialMore;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfilesCubit(onChanged: onChanged, initial: initial),
      child: _View(onMoreChanged: onMoreChanged, initialMore: initialMore),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.onMoreChanged, required this.initialMore});

  final ValueChanged<List<String>> onMoreChanged;
  final List<String> initialMore;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfilesCubit>();

    return BlocBuilder<ProfilesCubit, ProfilesState>(
      builder: (context, state) {
        final isMore = state.selected == ProfileType.more;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MORE PROFILES',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Gap(12.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: [
                for (final type in ProfileType.values)
                  _ProfileChip(
                    label: type.label,
                    selected: type == state.selected,
                    filled: state.filled.contains(type),
                    onTap: () => cubit.select(type),
                  ),
              ],
            ),
            Gap(16.h),

            Visibility(
              visible: isMore,
              maintainState: true,
              child: MultiFieldSection(
                title: 'More links',
                hint: 'https://',
                addLabel: 'Add another link',
                keyboardType: TextInputType.url,
                initialValues: initialMore,
                onChanged: onMoreChanged,
              ),
            ),

            if (!isMore) ...[
              Text(
                state.selected.fieldTitle,
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              Gap(8.h),
              TextField(
                key: ValueKey(state.selected),
                controller: cubit.controllers[state.selected],
                keyboardType: TextInputType.url,
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                cursorColor: Color.lerp(
                  const Color(0xFFD8D2C3),
                  Colors.black,
                  0.2,
                )!,
                style: GoogleFonts.dmSans(
                  fontSize: 16.sp,
                  color: AppAccent.primaryText[0],
                ),
                decoration: InputDecoration(
                  hintText: state.selected.hint,
                  hintStyle: GoogleFonts.dmSans(
                    color: const Color(0xFF757575),
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ProfileChip extends StatelessWidget {
  const _ProfileChip({
    required this.label,
    required this.selected,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ink = AppAccent.primaryText[0];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: selected ? ink : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: selected ? ink : const Color(0xFFD8D2C3)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : ink,
                  ),
                  child: Text(label),
                ),
                if (filled && !selected) ...[
                  Gap(8.w),
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: ink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
