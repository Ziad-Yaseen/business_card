import 'package:business_card/core/components/card_patterns.dart';
import 'package:business_card/features/create_card/cubit/pattern_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatternSelector extends StatelessWidget {
  const PatternSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatternCubit(),
      child: BlocBuilder<PatternCubit, int>(
        builder: (context, state) {
          final cubit = context.read<PatternCubit>();
          return Row(
            spacing: 12.w,
            children: List.generate(cubit.maxNumberOfPatterns, (index) {
              final pattern = index == 0
                  ? CardPattern.rings
                  : index == 1
                  ? CardPattern.stripes
                  : CardPattern.none;
              return Expanded(
                child: _PatternItem(
                  pattern: pattern,
                  isActive: state == index,
                  onTap: () => cubit.select(index),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _PatternItem extends StatelessWidget {
  const _PatternItem({
    required this.pattern,
    this.isActive = false,
    required this.onTap,
  });

  final CardPattern pattern;
  final bool isActive;
  final VoidCallback onTap;

  static const _cardW = 342.0;
  static const _cardH = 196.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: _cardW / _cardH,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2A55E0), Color(0xFF1636A0)],
            ),
            border: Border.all(
              color: Color(isActive ? 0xFF15171A : 0xFFD8D2C3),
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _cardW,
                height: _cardH,
                child: Stack(
                  children: [
                    CardPatternLayer(
                      pattern: pattern,
                      lineColor: Colors.white.withAlpha(30),
                      glossColor: Colors.white.withAlpha(40),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
