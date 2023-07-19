import 'dart:ui';

import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class settingsScreen extends StatefulWidget {
  static const String routeName = '/settings-screen';
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

// ignore: camel_case_types
class _settingsScreenState extends State<settingsScreen> {
  Locale appLocale = window.locale;

  @override
  Widget build(BuildContext context) {
    String selectedLanguage = context.locale.toString() == 'en'
        ? 'English'
        : 'Arabic'; // Default language is English

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
                });
              },
              items: <String>['English', 'Arabic'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                  onTap: () async {
                    value == 'English'
                        ? await context.setLocale(const Locale('en'))
                        : await context.setLocale(const Locale('ar'));
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
