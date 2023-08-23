import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';

import '../../translations/locale_keys.g.dart';

// ignore: camel_case_types
class headerMarkWidget extends StatefulWidget {
  const headerMarkWidget({
    super.key,
    required this.percentage,
    required this.total,
    required this.fullMark,
  });
  final double percentage;
  final double fullMark;
  final double total;

  @override
  State<headerMarkWidget> createState() => _headerMarkWidgetState();
}

class _headerMarkWidgetState extends State<headerMarkWidget> {
  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //this container is the head of the mark screen
    //it has user name , image , percentage , ect..
    return Container(
      padding: EdgeInsets.only(top: screenHight / 10),
      height: screenHight / 4,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 49, 104, 161),
            Color.fromARGB(255, 40, 70, 118),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    // width: screenWidth / 5,
                    // height: screenWidth / 6,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.ProfileColor, // Border color
                        width: 5.0, // Border width
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.total.toString(),
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LocaleKeys.grandtotal.tr(),
                          style: TextStyle(
                              fontSize: 11,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    // width: screenWidth / 5,
                    // height: screenWidth / 6,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.ProfileColor, // Border color
                        width: 5.0, // Border width
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.fullMark.toString(),
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LocaleKeys.fulltotal.tr(),
                          style: TextStyle(
                              fontSize: 11,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    // width: screenWidth / 5,
                    // height: screenWidth / 6,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.ProfileColor, // Border color
                        width: 5.0, // Border width
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' ${widget.percentage.toStringAsFixed(2).toString()}%',
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          LocaleKeys.percentage.tr(),
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
