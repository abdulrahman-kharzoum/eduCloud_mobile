import 'package:educloud_mobile/common_widgets/error_widget.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/notification_screen.dart';
import 'package:educloud_mobile/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/onboarding_screen.dart';
import '../screens/profile_screen.dart';

class AppRouter {
  static String get profileScreen => '/profile-screen';

  static String get onBoardingScreen => '/onboarding-screen';

  // all the route paths. So that we can access them easily  across the app
  static String get homeScreen => '/home-screen';
  static String get notificationScreen => '/notification-screen';
  static String get settingsScreen => '/settings-screen';
  static String get installmentsScreen => '/installments-screen';
  //static String get splashScreen => '/splash-screen';

  /// The route configuration.
  /// use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
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
