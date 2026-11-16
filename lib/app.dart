import 'package:business_card/core/cubit/theme_cubit.dart';
import 'package:business_card/core/cubit/theme_state.dart';
import 'package:business_card/core/routes/app_router.dart';
import 'package:business_card/core/styles/app_themes.dart';
import 'package:business_card/features/auth/cubit/auth_cubit.dart';
import 'package:business_card/features/main_layout/cubit/cards_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => CardsCubit()),
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
              themeMode: state.mode,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
