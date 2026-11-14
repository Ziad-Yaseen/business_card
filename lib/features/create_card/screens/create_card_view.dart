import 'package:business_card/core/components/main_card_preview.dart';
import 'package:business_card/core/components/main_text_field_with_laabel.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/create_card/cubit/create_card_cubit.dart';
import 'package:business_card/features/create_card/cubit/create_card_state.dart';
import 'package:business_card/features/create_card/cubit/tab_cubit.dart';
import 'package:business_card/features/create_card/widgets/color_selector.dart';
import 'package:business_card/features/create_card/widgets/create_card_app_bar.dart';
import 'package:business_card/features/create_card/widgets/more_profiles_section.dart';
import 'package:business_card/features/create_card/widgets/multi_field_section.dart';
import 'package:business_card/features/create_card/widgets/pattern_selector.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCardView extends StatelessWidget {
  const CreateCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TabCubit()),
        BlocProvider(create: (_) => CreateCardCubit()),
      ],
      child: BlocListener<CreateCardCubit, CreateCardState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case CreateStatus.saved:
              context.pop(true);
            case CreateStatus.invalid:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fill the required fields')),
              );
            case CreateStatus.failure:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not save the card')),
              );
            case CreateStatus.editing:
            case CreateStatus.saving:
              break;
          }
        },
        child: const _CreateCard(),
      ),
    );
  }
}

class _CreateCard extends StatelessWidget {
  const _CreateCard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const CreateCardAppBar(),
            Gap(12.h),
            BlocBuilder<CreateCardCubit, CreateCardState>(
              builder: (context, state) =>
                  MainCardPreview(card: state.toCard()),
            ),
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
    return DefaultTabController(
      length: 3,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppAccent.darkLerpedbg(context),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: TabBar(
          onTap: (index) => context.read<TabCubit>().select(index),
          labelStyle: GoogleFonts.dmSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppAccent.primaryText2(context),
          ),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppAccent.primaryText(context),
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelColor: AppAccent.primaryText2(context),
          unselectedLabelColor: AppAccent.unselectedTab(context),
          splashBorderRadius: BorderRadius.circular(20.r),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          labelPadding: EdgeInsets.symmetric(vertical: 12.h),
          tabs: const [Text('Look'), Text('Details'), Text('Links')],
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
    final labelStyle = GoogleFonts.dmSans(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
      color: const Color(0xFF5F636A),
    );

    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text('CARD COLOR', style: labelStyle),
        ),
        Gap(14.h),
        const ColorSelectorWidget(),
        Gap(24.h),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text('PATTERN', style: labelStyle),
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
    final cubit = context.read<CreateCardCubit>();
    final s = cubit.state;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MainTextField(
                title: 'First name',
                subTitle: 'Required',
                hint: 'e.g. Ziad',
                initialValue: s.firstName,
                onChanged: cubit.firstNameChanged,
              ),
            ),
            Gap(14.w),
            Expanded(
              child: MainTextField(
                title: 'Last name',
                subTitle: 'Required',
                hint: 'e.g. Yaseen',
                initialValue: s.lastName,
                onChanged: cubit.lastNameChanged,
              ),
            ),
          ],
        ),
        Gap(14.h),
        Row(
          children: [
            Expanded(
              child: MainTextField(
                title: 'Middle name',
                subTitle: 'Optional',
                hint: 'e.g. Ali',
                initialValue: s.middleName,
                onChanged: cubit.middleNameChanged,
              ),
            ),
            Gap(14.w),
            Expanded(
              child: MainTextField(
                title: 'Nick name',
                subTitle: 'Optional',
                hint: 'e.g. Zee',
                initialValue: s.nickName,
                onChanged: cubit.nickNameChanged,
              ),
            ),
          ],
        ),
        Gap(14.h),
        MainTextField(
          title: 'Job title',
          subTitle: 'Required',
          hint: 'e.g. Flutter Developer',
          initialValue: s.jobTitle,
          onChanged: cubit.jobTitleChanged,
        ),
        Gap(14.h),
        MainTextField(
          title: 'Company',
          subTitle: 'Optional',
          hint: 'e.g. Acme Labs',
          initialValue: s.company,
          onChanged: cubit.companyChanged,
        ),
        Gap(14.h),
        MultiFieldSection(
          title: 'Email',
          hint: 'ziad@example.com',
          addLabel: 'Add another email',
          keyboardType: TextInputType.emailAddress,
          initialValues: s.emails,
          onChanged: cubit.emailsChanged,
        ),
        Gap(14.h),
        MultiFieldSection(
          title: 'Phone',
          hint: '01080173273',
          addLabel: 'Add another phone',
          keyboardType: TextInputType.phone,
          initialValues: s.phones,
          onChanged: cubit.phonesChanged,
        ),
      ],
    );
  }
}

class _LinksTab extends StatelessWidget {
  const _LinksTab();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateCardCubit>();
    final s = cubit.state;

    return Column(
      children: [
        MainTextField(
          title: 'LinkedIn',
          subTitle: 'Required',
          hint: 'linkedin.com/in/your-name',
          initialValue: s.linkedIn,
          onChanged: cubit.linkedInChanged,
        ),
        Gap(14.h),
        MainTextField(
          title: 'GitHub',
          subTitle: 'Optional',
          hint: 'github.com/your-name',
          initialValue: s.github,
          onChanged: cubit.githubChanged,
        ),
        Gap(14.h),
        MainTextField(
          title: 'Portfolio',
          subTitle: 'Optional',
          hint: 'yourname.dev',
          initialValue: s.portfolio,
          onChanged: cubit.portfolioChanged,
        ),
        Gap(14.h),
        MoreProfilesSection(
          initial: s.profiles,
          initialMore: s.more,
          onChanged: cubit.profilesChanged,
          onMoreChanged: cubit.moreChanged,
        ),
      ],
    );
  }
}
