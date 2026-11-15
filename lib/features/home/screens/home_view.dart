import 'package:business_card/features/home/widgets/cards_view_widget.dart';
import 'package:business_card/features/home/widgets/home_app_bar.dart';
import 'package:business_card/features/home/widgets/no_cards_widget.dart';
import 'package:business_card/features/main_layout/cubit/cards_cubit.dart';
import 'package:business_card/features/main_layout/cubit/states/cards_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CardsCubit>();
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          BlocSelector<CardsCubit, CardsStates, int>(
            selector: (state) {
              return cubit.numberOfCards;
            },
            builder: (context, numberOfCards) {
              return HomeAppBar(numberOfCards: numberOfCards);
            },
          ),
          Expanded(
            child: BlocBuilder<CardsCubit, CardsStates>(
              builder: (context, state) {
                if (state is LoadingCards) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FaildCardsState) {
                  return Center(child: Text(state.error));
                }
                if (state is NoCardsState) return const NoCardsWidget();
                return const CardsViewWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
