import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/screens/supervisor/head_profile_sup.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:educloud_mobile/widgets/bus_screen_widgets/app_drawerSup.dart';
import 'package:educloud_mobile/widgets/supervisor_widgets/didGetIn_table.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/head_profile_widget.dart';

class AbsencesScreen extends StatelessWidget {
  const AbsencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> data = {
      'info': [
        {
          'name': 'ALAA SHIBANY',
          'haveToPay': 25.5,
        },
        {
          'name': 'ABDULLA MUSA',
          'haveToPay': 50.55,
        },
        {
          'name': 'ABDUALLA RAHMON',
          'haveToPay': 100.00,
        },
        {
          'name': 'ABDULRAHMAN KHARZOUM',
          'haveToPay': 0.00,
        },
        {
          'name': 'BAHAA',
          'haveToPay': 98,
        },
      ],
    };
    final Size mediaQuery = Size(screenWidth, screenHight / 1.1);
    return Scaffold(
      drawer: const appDrawerSup(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              // ignore: unrelated_type_equality_checks
              //check if the language english or arabic
              margin: context.locale.toString() == 'en'
                  ? EdgeInsets.only(right: screenWidth / 40)
                  : EdgeInsets.only(left: screenWidth / 40),
              child: Icon(
                Icons.cancel,
                size: 35,
                color: AppColors.grey2Color,
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
            child: headSupWidget(
              userName: "Ali Ahmed",
              userRole: "Bus Supervisor",
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
          TripTable(
            button_text: LocaleKeys.endingTrip.tr(),
            icon: Icon(
              Icons.check_circle_rounded,
              size: 30,
              color: Colors.green,
            ),
            icon2: Icon(
              Icons.cancel,
              size: 30,
              color: Colors.red,
            ),
            title: LocaleKeys.startingTrip.tr(),
            data: data,
            mediaQuery: mediaQuery,
          ),
        ],
      ),
    );
  }
}
