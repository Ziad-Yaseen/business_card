import 'package:business_card/core/components/main_back_button.dart';
import 'package:business_card/core/constants/app_colors.dart';
import 'package:business_card/features/create_card/cubit/create_card_cubit.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCardAppBar extends StatelessWidget {
  const CreateCardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      right: false,
      left: false,
      child: Row(
        children: [
          const MainBackButton(),
          Gap(12.w),
          Text(
            'New Card',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              color: AppAccent.primaryText(context),
            ),
          ),
          const Spacer(),
          Tooltip(
            message: 'Save',
            child: TextButton(
              onPressed: () => context.read<CreateCardCubit>().save(),
              child: Text(
                'Save',
                style: GoogleFonts.dmSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}