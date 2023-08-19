import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routing/app_router.dart';
import '../sever/apis.dart';
import '../styles/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/head_profile_widget.dart';
import '../widgets/installments_tab_widget.dart';

// ignore: camel_case_types
class schoolBusInfoScreen extends StatefulWidget {
  const schoolBusInfoScreen({super.key});

  @override
  State<schoolBusInfoScreen> createState() => _schoolBusInfoScreenState();
}

// ignore: camel_case_types
class _schoolBusInfoScreenState extends State<schoolBusInfoScreen> {
  Map<String, dynamic> data = {
    'totalPrice': 5000000,
    'stillHaveToPay': 1200000,
    'paied': 3800000,
    'info': [
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
      },
      {'receipt': '1232414525657254', 'date': '\\11\\7\\2022\\', 'price': 50000}
    ],
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const appDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        actions: [
          IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: AppColors.mainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
        title: Container(
          margin: context.locale.toString() == 'en'
              ? EdgeInsets.only(left: screenWidth / 100, top: screenHight / 100)
              : EdgeInsets.only(
                  right: screenWidth / 100, top: screenHight / 100),
          child: InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRouter.profileScreen),
            child: headProfileWidget(
              icon: const Icon(
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
      ),
      body: Padding(
        padding: EdgeInsets.only(top: screenHight / 15),
        child: //bus
            Apis.studentExpensesInfo['data']['busBill'] != null
                ? installmentsTab(
                    mediaQuery: MediaQuery.of(context).size,
                    data: Apis.studentExpensesBusInfo['data'],
                    paied: Apis.studentExpensesInfo['data']['paidForBusBill'],
                    totalPrice: Apis.studentExpensesInfo['data']['busBill']
                        ['value'],
                    haveToPay: Apis.studentExpensesInfo['data']['busBill']
                            ['value'] -
                        Apis.studentExpensesInfo['data']['paidForBusBill'])
                : installmentsTab(
                    mediaQuery: MediaQuery.of(context).size,
                    data: [],
                    paied: Apis.studentExpensesInfo['data']['paidForBusBill'],
                    totalPrice: -1,
                    haveToPay: -1),
      ),
    );
  }
}
