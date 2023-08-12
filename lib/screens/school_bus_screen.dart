import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:educloud_mobile/widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/bus_screen_widgets/bus_screen_container_widget.dart';
import '../widgets/bus_screen_widgets/map_widget.dart';
import '../widgets/head_profile_widget.dart';

// ignore: camel_case_types
class schoolBusScreen extends StatefulWidget {
  static const String routeName = '';
  const schoolBusScreen({super.key});

  @override
  State<schoolBusScreen> createState() => _schoolBusScreenState();
}

// ignore: camel_case_types
class _schoolBusScreenState extends State<schoolBusScreen> {
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
                Navigator.pushReplacementNamed(context, AppRouter.homeScreen);
              }),
        ],
        title: Container(
          margin: context.locale.toString() == 'en'
              ? EdgeInsets.only(left: screenWidth / 100, top: screenHight / 100)
              : EdgeInsets.only(
                  right: screenWidth / 100, top: screenHight / 100),
          child: headProfileWidget(
            icon: Icon(
              CupertinoIcons.person,
              size: 25,
            ),
            circleColor: AppColors.secondaryColor,
            studentName: 'Alaa shibany',
            gradeNumber: 'Grade 9',
            screenHight: screenHight,
            screenWidth: screenWidth,
            nameColor: AppColors.mainColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: screenHight / 15),
        child: Column(
          children: [
            //here we have to containers for info
            busScreenContainerWidget(
              screenWidth: screenWidth,
              screenHight: screenHight,
              title1: LocaleKeys.thetotalprice.tr(),
              widget1: Text(
                '1000 ${LocaleKeys.spy.tr()}',
                style: AppTextStyles.poppinsTitle3,
              ),
              title2: LocaleKeys.thetotalpriceyoupaied.tr(),
              widget2: Text(
                '1000 ${LocaleKeys.spy.tr()}',
                style: AppTextStyles.poppinsTitle4,
              ),
              title3: LocaleKeys.stillhavetopay.tr(),
              widget3: Text(
                '1000 ${LocaleKeys.spy.tr()}',
                style: AppTextStyles.poppinsTitle4,
              ),
            ),
            SizedBox(
              height: screenHight / 50,
            ),
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, AppRouter.schoolBusInfoSc),
              child: busScreenContainerWidget(
                screenWidth: screenWidth,
                screenHight: screenHight,
                title1: LocaleKeys.lastpriceyoupaied.tr(),
                widget1: Text(
                  '100 ${LocaleKeys.spy.tr()}',
                  style: AppTextStyles.poppinsTitle3,
                ),
                title2: LocaleKeys.date.tr(),
                widget2: Text(
                  '12/1/2066',
                  style: AppTextStyles.poppinsTitle4,
                ),
                title3: LocaleKeys.receiptnumber.tr(),
                widget3: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.mainColor,
                    size: screenHight / 50,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHight / 13.5,
            ),
            mapWidget(
              screenWidth: screenWidth,
              screenHight: screenHight,
              bottom: InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.locationScreen),
                child: Container(
                  height: screenHight / 20,
                  width: screenWidth / 2.5,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.follownow.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
