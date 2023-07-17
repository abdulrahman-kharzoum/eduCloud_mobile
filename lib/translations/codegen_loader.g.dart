// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "settings": "الإعدادات",
    "languagesellect": "اختر اللغة",
    "advertisements": "الإعلانات",
    "studentsubjects": "مواد الطالب",
    "expenses&installments": "المصاريف و الأقساط",
    "schoolbuslocation": "موقع حافلة المدرسة",
    "suggestions&complaints": "الإقتراحات و الشكاوى",
    "homepage": "الصفحة الرئيسية",
    "messages&notifications": "الرسائل و الإشعارات",
    "logout": "تسجيل الخروج",
    "calender": "التقويم"
  };
  static const Map<String, dynamic> en = {
    "settings": "Settings",
    "languagesellect": "Sellect language",
    "advertisements": "Advertisements",
    "studentsubjects": "Student subjects",
    "expenses&installments": "Expenses & installments",
    "schoolbuslocation": "School Bus location",
    "suggestions&complaints": "Suggestions & complaints",
    "homepage": "Home page",
    "messages&notifications": "Messages & Notifications",
    "logout": "Log out",
    "calender": "Calender"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en
  };
}
