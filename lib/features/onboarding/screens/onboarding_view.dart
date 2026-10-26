import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:business_card/features/onboarding/widgets/card_data.dart';
import 'package:business_card/features/onboarding/widgets/card_one.dart';
import 'package:business_card/features/onboarding/widgets/my_app_icon_widget.dart';
import 'package:business_card/features/onboarding/widgets/page_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(), 
      child: _OnboardingView(onFinish: () {}),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView({required this.onFinish});

  final VoidCallback onFinish;

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final PageController _controller = PageController();
  List<Widget> screens = [
    const CardData(
      card: CardOne(),
      color: Color(0xFFF9D9CD),
      title: 'Your details, in one card.',
      subTitle: 'Add your name, links and contact info once. Update it whenever you like.',
    ),

    const CardData(
      card: SizedBox(),
      color: Color(0xFFD9E2FB),
      title: 'Share with a scan.',
      subTitle: 'Show the QR code or send the link. They see your card in any browser, no app needed.',
    ),

    const CardData(
      card: SizedBox(),
      color: Color(0xFFD6E9DE),
      title: 'A card for every side of you.',
      subTitle: 'Keep separate cards for work, freelance and personal, each with its own look.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    final cubit = context.read<OnboardingCubit>();
    if (cubit.isLast) {
      widget.onFinish();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Gap(24.w),
                const MyAppIconWidget(),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: AppAccent.bg[0].withValues(alpha: 0.5),
                    ),
                    onPressed: widget.onFinish,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.dmSans(
                        fontSize: 14.sp,
                        fontWeight: .w600,
                        color: AppAccent.primaryText[0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: OnboardingCubit.pageCount,
                onPageChanged: context.read<OnboardingCubit>().pageChanged,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center(child: screens[i]),
                ),
              ),
            ),
            PageDots(controller: _controller, count: OnboardingCubit.pageCount),
            Gap(24.h),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.w),
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<OnboardingCubit, int>(
                  builder: (context, page) {
                    final isLast = page == OnboardingCubit.pageCount - 1;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 8),
                            blurRadius: 8,
                            spreadRadius: 0,
                            color: AppAccent.splashBg.withValues(alpha: 0.28),
                          ),
                        ],
                      ),
                      child: FilledButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppAccent.splashBg,
                        ),
                        onPressed: _next,
                        child: Text(isLast ? 'Get started' : 'Continue'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
