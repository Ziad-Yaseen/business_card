import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/create_card/cubit/tab_cubit.dart';
import 'package:business_card/features/create_card/widgets/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
            const _CreateCardAppBar(),
            Gap(12.h),
            const _CardPreview(pattern: CardPattern.rings),
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
        
      ],
    );
  }
}

class _DetailsTab extends StatelessWidget {
  const _DetailsTab();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _LinksTab extends StatelessWidget {
  const _LinksTab();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _CreateCardAppBar extends StatelessWidget {
  const _CreateCardAppBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      right: false,
      left: false,
      child: Row(
        children: [
          const _BackButton(),
          Gap(12.w),
          Text(
            'New Card',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24.sp,
              fontWeight: .w700,
              letterSpacing: -0.6,
              color: AppAccent.primaryText[0],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: GoogleFonts.dmSans(fontSize: 15.sp, fontWeight: .w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

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

class _CardPreview extends StatelessWidget {
  const _CardPreview({required this.pattern, this.lightContent = true});
  final CardPattern pattern;
  final bool lightContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A55E0), Color(0xFF1636A0)],
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
            color: Colors.black.withValues(alpha: 0.1),
          ),
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            CardPatternLayer(
              pattern: pattern,
              lineColor: Colors.black.withAlpha(30),
              glossColor: Colors.black.withAlpha(40),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          'Ziad Yaseen',
                          style: GoogleFonts.bricolageGrotesque(
                            fontSize: 24.sp,
                            color: lightContent
                                ? Colors.white
                                : const Color(0xFF15171A),
                            fontWeight: .w700,
                          ),
                        ),
                        const _CompanyContainer(company: 'Company'),
                      ],
                    ),
                    Gap(4.h),
                    Text(
                      'Mobile App Developer',
                      style: GoogleFonts.dmSans(
                        fontSize: 14.sp,
                        fontWeight: .w500,
                        color: lightContent
                            ? Colors.white
                            : AppAccent.primaryText[0].withValues(
                                alpha: lightContent ? 85 : 90,
                              ),
                      ),
                    ),
                    Gap(10.h),

                    Row(
                      mainAxisAlignment: .spaceBetween,
                      crossAxisAlignment: .end,
                      children: [
                        Text(
                          'ziadyaseen.dev@gmail.com',
                          style: GoogleFonts.dmSans(
                            color: lightContent
                                ? Colors.white
                                : AppAccent.primaryText[0],
                            fontSize: 13.sp,
                          ),
                        ),
                        const _profile(name: 'ZY'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyContainer extends StatelessWidget {
  const _CompanyContainer({required this.company, this.lightContent = true});
  final String company;
  final bool lightContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: lightContent
            ? Colors.white.withValues(alpha: 0.18)
            : const Color(0xFF15171A).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        company,
        style: GoogleFonts.dmSans(
          color: lightContent ? Colors.white : AppAccent.primaryText[0],
          fontSize: 11.sp,
          letterSpacing: 0.88,
          fontWeight: .w600,
        ),
      ),
    );
  }
}

class _profile extends StatelessWidget {
  const _profile({required this.name, this.image, this.lightContent = true});
  final bool lightContent;
  final String name;
  final String? image;

  @override
  Widget build(BuildContext context) {
    const Color lightColor = Color(0xFFFFFFFF);
    const Color darkColor = Color(0xFF333333);
    final Color color = lightContent ? lightColor : darkColor;
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        shape: .circle,
        border: Border.all(color: color.withValues(alpha: 0.35), width: 2),
      ),
      child: Text(
        name,
        style: GoogleFonts.bricolageGrotesque(
          color: color,
          fontSize: 19,
          fontWeight: .w700,
        ),
      ),
    );
  }
}
