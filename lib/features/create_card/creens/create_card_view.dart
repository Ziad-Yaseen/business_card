import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/core/components/main_card_preview.dart';
import 'package:business_card/core/components/main_text_field_with_laabel.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/create_card/cubit/tab_cubit.dart';
import 'package:business_card/features/create_card/widgets/color_selector.dart';
import 'package:business_card/features/create_card/widgets/create_card_app_bar.dart';
import 'package:business_card/features/create_card/widgets/more_profiles_section.dart';
import 'package:business_card/features/create_card/widgets/multi_field_section.dart';
import 'package:business_card/features/create_card/widgets/pattern_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCardView extends StatelessWidget {
  const CreateCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => TabCubit(), child: const _CreateCard());
  }
}

class _CreateCard extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const CreateCardAppBar(),
            Gap(12.h),
            const MainCardPreview(pattern: CardPattern.rings),
            Gap(16.h),
            const _TabBar(),
            Gap(16.h),
            const _Body(),
          ],
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, int>(
      builder: (context, state) => DefaultTabController(
        length: 3,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: const Color(0xFFEAE5D8),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: TabBar(
            onTap: (index) => context.read<TabCubit>().select(index),
            labelStyle: GoogleFonts.dmSans(
              fontSize: 14.sp,
              fontWeight: .w600,
              color: const Color(0xFFF4F1EA),
            ),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: AppAccent.primaryText[0],
              borderRadius: BorderRadius.circular(20.r),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF5F636A),
            splashBorderRadius: BorderRadius.circular(20.r),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelPadding: EdgeInsets.symmetric(vertical: 12.h),
            tabs: const [Text('Look'), Text('Details'), Text('Links')],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, int>(
      builder: (_, state) => state == 0
          ? const _LookTab()
          : state == 1
          ? const _DetailsTab()
          : const _LinksTab(),
    );
  }
}

class _LookTab extends StatelessWidget {
  const _LookTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'card color'.toUpperCase(),
              style: GoogleFonts.dmSans(
                fontSize: 12.sp,
                fontWeight: .w500,
                letterSpacing: 0.6,
                color: const Color(0xFF5F636A),
              ),
            ),
            Text(
              'Ocean',
              style: GoogleFonts.dmSans(
                fontSize: 12.sp,
                fontWeight: .w500,
                color: AppAccent.primaryText[0],
              ),
            ),
          ],
        ),
        Gap(14.h),
        const ColorSelectorWidget(),
        Gap(24.h),
        Align(
          alignment: .centerStart,
          child: Text(
            'Pattern'.toUpperCase(),
            style: GoogleFonts.dmSans(
              fontSize: 12.sp,
              fontWeight: .w500,
              letterSpacing: 0.6,
              color: const Color(0xFF5F636A),
            ),
          ),
        ),
        Gap(12.h),
        const PatternSelector(),
      ],
    );
  }
}

class _DetailsTab extends StatelessWidget {
  const _DetailsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: MainTextField(
                  title: 'First name',
                  subTitle: 'Required',
                  hint: 'e.g. Ziad',
                ),
              ),
              Gap(14.w),
              const Expanded(
                child: MainTextField(
                  title: 'last name',
                  subTitle: 'Required',
                  hint: 'e.g. Yaseen',
                ),
              ),
            ],
          ),

          Gap(14.h),
          Row(
            children: [
              const Expanded(
                child: MainTextField(
                  title: 'Middle name',
                  subTitle: 'Optional',
                  hint: 'e.g. Ali',
                ),
              ),
              Gap(14.w),
              const Expanded(
                child: MainTextField(
                  title: 'Nick name',
                  subTitle: 'Optional',
                  hint: 'e.g. Zee',
                ),
              ),
            ],
          ),
          Gap(14.h),
          const MainTextField(
            title: 'Job title',
            subTitle: 'Required',
            hint: 'e.g. Flutter Developer',
          ),

          Gap(14.h),
          const MainTextField(
            title: 'Company',
            subTitle: 'Optional',
            hint: 'e.g. Acme Labs',
          ),

          Gap(14.h),
          MultiFieldSection(
            title: 'Email',
            hint: 'ziad@example.com',
            addLabel: 'Add another email',
            onChanged: (emails) {},
          ),

          MultiFieldSection(
            title: 'Phone',
            hint: '01080173273',
            addLabel: 'Add another phone',
            onChanged: (emails) {},
          ),
        ],
      ),
    );
  }
}

class _LinksTab extends StatelessWidget {
  const _LinksTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MainTextField(
            title: 'LinkedIn',
            subTitle: 'Required',
            hint: 'linkedin.com/in/your-name',
          ),

          Gap(14.h),
          const MainTextField(
            title: 'GitHub',
            subTitle: 'Optional',
            hint: 'github.com/your-name',
          ),

          Gap(14.h),
          const MainTextField(
            title: 'Portfolio',
            subTitle: 'Optional',
            hint: 'yourname.dev',
          ),

          Gap(14.h),

          MoreProfilesSection(
            onChanged: (profiles) {
              // {ProfileType.instagram: '@ziad', ...} → CardModel.instagram / facebook / tiktok / x
            },
            onMoreChanged: (links) {
              // → CardModel.more
            },
          ),
        ],
      ),
    );
  }
}
