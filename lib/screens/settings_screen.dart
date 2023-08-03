import 'dart:ui';

import 'package:educloud_mobile/constants/sharedPreferences.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class settingsScreen extends StatefulWidget {
  static const String routeName = '/settings-screen';
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

// ignore: camel_case_types
class _settingsScreenState extends State<settingsScreen> {
  Locale appLocale = window.locale; // Default language is English

  @override
  Widget build(BuildContext context) {
    String selectedLanguage =
        context.locale.toString() == 'en' ? 'English' : 'Arabic';
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr()),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              LocaleKeys.languagesellect.tr(),
            ),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                  // Save the selected language to local storage or a backend server
                  // For example, you can use shared preferences package to store the language.
                });
              },
              items: <String>['English', 'Arabic'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: () async {
                    final _preferences = await SharedPreferences.getInstance();
                    if (value == 'English') {
                      await context.setLocale(const Locale('en'));
                      _preferences.setString(LanguageId, value);
                    } else {
                      await context.setLocale(const Locale('ar'));
                      _preferences.setString(LanguageId, value);
                    }
                    context.read<OnboardingProvider>().getSubTextsList();
                    context.read<OnboardingProvider>().getTextsList();

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (Route<dynamic> route) => false);
                  },
                );
              }).toList(),
            ),
          ),
          // Add other settings widgets here
        ],
      ),
    );
  }
}



// onTap: () async {
                  //   value == 'English'
                  //       ? await context.setLocale(const Locale('en'))
                  //       : await context.setLocale(const Locale('ar'));
                  // },