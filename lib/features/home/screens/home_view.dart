import 'package:business_card/features/home/widgets/cards_list_widget.dart';
import 'package:business_card/features/home/widgets/home_app_bar.dart';
import 'package:business_card/features/home/widgets/no_cards_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const HomeAppBar(numberOfCards: 3),
              Gap(24.h),
              CardsListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
