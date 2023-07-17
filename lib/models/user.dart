import 'package:educloud_mobile/screens/profile_screen.dart';
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
      InfoCard("Phone number", phone_number, Icons.phone),
      InfoCard("Grade/Section", grade_section, Icons.school_rounded),
      InfoCard("Father name", fatherName, Icons.person),
      InfoCard("Mother name", motherName, Icons.person),
      InfoCard("Address", Address, Icons.location_on),
    ];
  }
}
