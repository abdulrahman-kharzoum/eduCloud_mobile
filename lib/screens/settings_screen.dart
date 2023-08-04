import 'dart:ui';

import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

// ignore: camel_case_types
class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  Locale appLocale = window.locale;

  @override
  Widget build(BuildContext context) {
    String _selectedLanguage = context.locale.toString() == 'en'
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
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                  // Save the selected language to local storage or a backend server
                  // For example, you can use shared preferences package to store the language.
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
                      Navigator.pushReplacementNamed(
                          context, AppRouter.homeScreen);
                    });
              }).toList(),
            ),
          ),
          // Add other settings widgets here
        ],
      ),
    );
  }
}
