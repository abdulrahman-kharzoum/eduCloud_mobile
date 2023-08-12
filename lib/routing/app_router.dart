import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/installments_screen.dart';
import 'package:educloud_mobile/screens/mark1_screen.dart';
import 'package:educloud_mobile/screens/notification_screen.dart';
import 'package:educloud_mobile/screens/school_bus_info_screen.dart';
import 'package:educloud_mobile/screens/settings_screen.dart';
import 'package:educloud_mobile/screens/splash_screen.dart';
import 'package:educloud_mobile/screens/suggestions_screen.dart';

import 'package:flutter/material.dart';

import '../screens/error_screen.dart';
import '../screens/marks_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/school_bus_screen.dart';

class AppRouter {
  static String get profileScreen => '/profile-screen';

  static String get onBoardingScreen => '/onboarding-screen';

  static String get homeScreen => '/home-screen';
  static String get mark2Screen => '/mark2-screen';
  static String get mark1Screen => '/mark1-screen';
  static String get suggestionScreen => '/suggestion-screen';

  static String get notificationScreen => '/notification-screen';
  static String get settingsScreen => '/settings-screen';
  static String get installmentsScreen => '/installments-screen';
  static String get splashScreen => '/splash-screen';
  static String get schoolBusSc => '/school-bus-screen';
  static String get schoolBusInfoSc => '/school-bus-info-screen';

  Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      if (routesMap.containsKey(settings.name)) {
        var method = routesMap[settings.name]!;
        return method.call(settings);
      }
      return _errorRoute;
    } catch (e) {
      return _errorRoute;
    }
  }

  static final MaterialPageRoute _errorRoute = MaterialPageRoute(builder: (_) {
    return ErrorScreen();
  });

  Map<String, MaterialPageRoute Function(RouteSettings)> routesMap = {
    suggestionScreen: (s) =>
        MaterialPageRoute(builder: (_) => SuggestionScreen(), settings: s),
    mark2Screen: (s) =>
        MaterialPageRoute(builder: (_) => MarksScreen(), settings: s),
    onBoardingScreen: (s) =>
        MaterialPageRoute(builder: (_) => OnboardingScreen(), settings: s),
    mark1Screen: (s) =>
        MaterialPageRoute(builder: (_) => Mark1Screen(), settings: s),
    profileScreen: (s) =>
        MaterialPageRoute(builder: (_) => ProfileScreen(), settings: s),
    installmentsScreen: (s) =>
        MaterialPageRoute(builder: (_) => InstallmentsScreen(), settings: s),
    settingsScreen: (s) =>
        MaterialPageRoute(builder: (_) => SettingsScreen(), settings: s),
    homeScreen: (s) =>
        MaterialPageRoute(builder: (_) => HomeScreen(), settings: s),
    notificationScreen: (s) =>
        MaterialPageRoute(builder: (_) => NotificationScreen(), settings: s),
    splashScreen: (s) =>
        MaterialPageRoute(builder: (_) => SplashScreen(), settings: s),
    schoolBusSc: (s) =>
        MaterialPageRoute(builder: (_) => const schoolBusScreen(), settings: s),
    schoolBusInfoSc: (s) => MaterialPageRoute(
        builder: (_) => const schoolBusInfoScreen(), settings: s),
  };
}
