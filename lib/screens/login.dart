import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Login'),
      actions: [
        Consumer<OnboardingProvider>(
          builder: (context, value, child) => IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showLogin', false);

                value.islastpage_false();

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => OnboardingScreen()));
              },
              icon: Icon(Icons.logout)),
        )
      ],
    ));
  }
}
