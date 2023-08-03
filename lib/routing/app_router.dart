import 'package:educloud_mobile/common_widgets/error_widget.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/installments_screen.dart';
import 'package:educloud_mobile/screens/mark1_screen.dart';
import 'package:educloud_mobile/screens/notification_screen.dart';
import 'package:educloud_mobile/screens/settings_screen.dart';
import 'package:educloud_mobile/screens/splash_screen.dart';
import 'package:educloud_mobile/services/pusher_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/marks_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/profile_screen.dart';

class AppRouter {
  static String get profileScreen => '/profile-screen';

  static String get onBoardingScreen => '/onboarding-screen';

  static String get homeScreen => '/home-screen';
  static String get mark2Screen => '/mark2-screen';
  static String get mark1Screen => '/mark1-screen';

  static String get notificationScreen => '/notification-screen';
  static String get settingsScreen => '/settings-screen';
  static String get installmentsScreen => '/installments-screen';

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: mark2Screen,
        builder: (BuildContext context, GoRouterState state) {
          return Mark1Screen();
        },
      ),
      GoRoute(
        path: mark1Screen,
        builder: (BuildContext context, GoRouterState state) {
          return MarksScreen();
        },
      ),
      GoRoute(
        path: settingsScreen,
        builder: (BuildContext context, GoRouterState state) {
          return SettingsScreen();
        },
      ),
      GoRoute(
        path: installmentsScreen,
        builder: (BuildContext context, GoRouterState state) {
          return InstallmentsScreen();
        },
      ),
      GoRoute(
        path: profileScreen,
        builder: (BuildContext context, GoRouterState state) {
          return ProfileScreen();
        },
      ),
      GoRoute(
        path: onBoardingScreen,
        builder: (BuildContext context, GoRouterState state) {
          return OnboardingScreen();
        },
      ),
      GoRoute(
        path: homeScreen,
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: notificationScreen,
        builder: (BuildContext context, GoRouterState state) {
          return NotificationScreen();
        },
      ),
    ],
    errorBuilder: errorWidget,
  );

  // to call it in views
  static GoRouter get router => _router;
}
