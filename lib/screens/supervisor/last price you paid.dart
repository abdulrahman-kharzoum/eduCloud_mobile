import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/head_profile_widget.dart';
import '../../widgets/supervisor_widgets/payment_table.dart';

class PricePaid extends StatelessWidget {
  const PricePaid({super.key});

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
        actions: [],
      ),
      body: Column(
        children: [
          Container(
            margin: context.locale.toString() == 'en'
                ? EdgeInsets.only(top: screenHight / 17, left: screenWidth / 5)
                : EdgeInsets.only(
                    top: screenHight / 17, right: screenWidth / 5),
            child: headProfileWidget(
              icon: Icon(
                CupertinoIcons.bus,
                color: AppColors.secondaryColor,
                size: 25,
              ),
              circleColor: AppColors.mainColor,
              screenHight: screenHight,
              screenWidth: screenWidth,
              nameColor: AppColors.mainColor,
            ),
          ),
          PaymentTableSupervisor(
            data: data,
            mediaQuery: mediaQuery,
          ),
        ],
      ),
    );
  }
}
