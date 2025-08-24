import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../bmi/bmi_result_args.dart';
import '../bmi/bmi_result_screen.dart';
import '../bmi/bmi_screen.dart';
import '../profile/profile_screen.dart';
import '../schedule/schedule_screen.dart';
import '../splash/splash_screen.dart';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';
import '../auth/profile_setup_screen.dart';
import '../shell/home_shell.dart';

// (Optional) keep these if you added the class details flow:
import '../classes/class_detail_screen.dart';
import '../classes/class_detail_args.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (_, __) => const SignUpScreen()),
    GoRoute(
        path: '/profile-setup', builder: (_, __) => const ProfileSetupScreen()),
    GoRoute(path: '/', builder: (_, __) => const HomeShell()),

    // OPTIONAL: tap from Search to open a class detail page
    GoRoute(
      path: '/class/:slug',
      name: 'classDetail',
      builder: (context, state) {
        final args = state.extra as ClassDetailArgs?;
        final slug = state.pathParameters['slug'] ?? 'class';
        return ClassDetailScreen(
          args: args ??
              ClassDetailArgs(
                name: slug,
                category: 'Gym Classes',
                distance: '—',
                rating: 0,
                heroImageUrl: '',
              ),
        );
      },
    ),
    GoRoute(path: '/schedule', builder: (_, __) => const ScheduleScreen()),
    GoRoute(path: '/bmi', builder: (_, __) => const BMIScreen()),
    GoRoute(
      path: '/bmi/result',
      name: 'bmiResult',
      builder: (context, state) {
        final args = state.extra as BMIResultArgs?;
        return BMIResultScreen(
          args: args ??
              const BMIResultArgs(
                bmi: 0,
                label: '-',
                message: 'No data',
                color: Colors.grey,
                gender: '-',
                age: 0,
                heightIn: 0,
                weightKg: 0,
              ),
        );
      },
    ),
    GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
  ],
);
