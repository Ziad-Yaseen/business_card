import 'package:business_card/core/routes/route_names.dart';
import 'package:business_card/features/main_layout/screens/main_layout.dart';
import 'package:business_card/features/onboarding/screens/onboarding_view.dart';
import 'package:business_card/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      ),

      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MainLayout(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),

      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),
    ],
  );
}
