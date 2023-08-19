import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/constants/sharedPreferences.dart';

import 'package:educloud_mobile/providers/onboarding_proivder.dart';

import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routing/app_router.dart';
import '../screens/chat_gpt.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 1), () async {
      context.read<OnboardingProvider>().stSize(MediaQuery.of(context).size);
      final _perf = await SharedPreferences.getInstance();
      if (_perf.getString(LanguageId) == 'English') {
        await context.setLocale(const Locale('en'));
      } else {
        await context.setLocale(const Locale('ar'));
      }
      context.read<OnboardingProvider>().getSubTextsList();
      context.read<OnboardingProvider>().getTextsList();
      if (_perf.containsKey(token) &&
          _perf.getString(token)!.isNotEmpty &&
          _perf.containsKey(role) &&
          _perf.getStringList(role)!.contains("student")) {
        Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
      } else if (_perf.containsKey(token) &&
          _perf.getString(token)!.isNotEmpty &&
          _perf.containsKey(role) &&
          _perf.getStringList(role)!.contains("principal")) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, AppRouter.supervisorContacts);
      } else if (_perf.containsKey(token) &&
          _perf.getString(token)!.isNotEmpty &&
          _perf.containsKey(role) &&
          _perf.getStringList(role)!.contains("supervisor")) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, AppRouter.supervisorContacts);
      } else if (_perf.containsKey(token) &&
          _perf.getString(token)!.isNotEmpty &&
          _perf.containsKey(role) &&
          _perf.getStringList(role)!.contains("busSupervisor")) {
        Navigator.pushReplacementNamed(context, AppRouter.homeScreenSup);
      } else {
        Navigator.pushReplacementNamed(context, AppRouter.onBoardingScreen);
      }
      /* Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return OnboardingScreen();
        },
      )
          
      );*/
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.appColor],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        ),
        child: Center(child: Icon(Icons.miscellaneous_services_outlined)),
      ),
    );
  }
}
