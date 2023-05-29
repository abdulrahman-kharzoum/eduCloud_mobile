import 'dart:async';

import 'package:educloud_mobile/main.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/screens/onboarding_screen.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 1), () {
      // print(MediaQuery.of(context).size);
      context.read<OnboardingProvider>().stSize(MediaQuery.of(context).size);
      // print(context.watch()<BaseProvider>().size);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return OnboardingScreen();
        },
      ));
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
