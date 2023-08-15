import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/widgets/PaymentTableStudent.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/head_profile_widget.dart';

class StudentBusPay extends StatelessWidget {
  const StudentBusPay({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> data = {
      'totalPrice': 5000000,
      'stillHaveToPay': 1200000,
      'paied': 3800000,
      'info': [
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 1000000
        },
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 50000
        },
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 50000
        },
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 50000
        },
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 50000
        },
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 50000
        },
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 50000
        }
      ],
    };
    final Size mediaQuery = Size(screenWidth, screenHight / 1.3);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.mainColor),
          onPressed: () => Navigator.of(context).pop(),
          color: AppColors.mainColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRouter.notificationScreen),
            child: Container(
              // ignore: unrelated_type_equality_checks
              //check if the language english or arabic
              margin: context.locale.toString() == 'en'
                  ? EdgeInsets.only(right: screenWidth / 40)
                  : EdgeInsets.only(left: screenWidth / 40),
              child: Icon(
                Icons.notifications,
                color: AppColors.titleTextColor,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: context.locale.toString() == 'en'
                ? EdgeInsets.only(top: screenHight / 17, left: screenWidth / 5)
                : EdgeInsets.only(
                    top: screenHight / 17, right: screenWidth / 5),
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRouter.profileScreen),
              child: headProfileWidget(
                icon: Icon(
                  CupertinoIcons.person,
                  size: 25,
                ),
                circleColor: AppColors.secondaryColor,
                screenHight: screenHight,
                screenWidth: screenWidth,
                nameColor: AppColors.mainColor,
              ),
            ),
          ),
          PaymentTableStudent(
            data: data,
            mediaQuery: mediaQuery,
          ),
        ],
      ),
    );
  }
}
