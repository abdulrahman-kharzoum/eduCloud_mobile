import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/screens/profile_screen.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

class User {
  String phone_number;
  String grade_section;
  String fatherName;
  String motherName;
  String Address;
  late List<InfoCard> info_cards;
  User(
      {required this.phone_number,
      required this.grade_section,
      required this.fatherName,
      required this.motherName,
      required this.Address}) {
    info_cards = [
      InfoCard(LocaleKeys.phoneNumber.tr(), phone_number, Icons.phone),
      InfoCard(
          LocaleKeys.grade_section.tr(), grade_section, Icons.school_rounded),
      InfoCard(LocaleKeys.fatherName.tr(), fatherName, Icons.person),
      InfoCard(LocaleKeys.motherName.tr(), motherName, Icons.person),
      InfoCard(LocaleKeys.address.tr(), Address, Icons.location_on),
    ];
  }
}
