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
  String _selectedLanguage = 'English'; // Default language is English

  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
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