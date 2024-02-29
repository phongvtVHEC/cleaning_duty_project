import 'package:cleaning_duty_project/feature/routers/screen_route.dart';
import 'package:cleaning_duty_project/feature/screen/login.dart';
import 'package:cleaning_duty_project/feature/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  redirect: (context, state) {
    if (ScreenRoute.publicRoute.contains(state.fullPath)) {
      return null;
    }
    return ScreenRoute.loginScreen;
  },
  routes: [
    GoRoute(
      path: ScreenRoute.loginScreen,
      pageBuilder: (context, state) => MaterialPage(
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      path: ScreenRoute.registerScreen,
      pageBuilder: (context, state) => const MaterialPage(
        child: RegisterScreen(),
      ),
    ),
  ],
);
