import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common_widgets/BackgroundPaint.dart';
import '../routing/app_router.dart';
import '../styles/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/head_profile_widget.dart';
import '../widgets/installments_tab_widget.dart';

// ignore: camel_case_types
class InstallmentsScreen extends StatefulWidget {
  static const String routeName = '/installments-screen';

  const InstallmentsScreen({super.key});

  @override
  State<InstallmentsScreen> createState() => _InstallmentsScreenState();
}

// ignore: camel_case_types
class _InstallmentsScreenState extends State<InstallmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

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
        {
          'receipt': '1232414525657254',
          'date': '\\11\\7\\2022\\',
          'price': 50000
        }
      ],
    };
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const appDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      ),
      body: CustomPaint(
        size: Size(
            screenWidth,
            (screenWidth * 2.1434668500180276)
                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: Background(),
        child: Column(
          // padding: EdgeInsets.zero,
          children: [
            //this head widget for user name and image and grade
            Container(
              margin: context.locale.toString() == 'en'
                  ? EdgeInsets.only(
                      top: screenHight / 25, left: screenWidth / 5)
                  : EdgeInsets.only(
                      top: screenHight / 25, right: screenWidth / 5),
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
            SizedBox(
              height: screenHight / 50,
            ),
            tabsWithoutIcon(
              controller: controller,
              mediaQuery: MediaQuery.of(context).size,
              tabs: [
                Tab(
                  text: LocaleKeys.bus.tr(),
                ),
                Tab(
                  text: LocaleKeys.school.tr(),
                ),
                Tab(
                  text: LocaleKeys.donations.tr(),
                ),
              ],
            ),
            SizedBox(
              height: screenHight / 50,
            ),
            SlidesForTabs(
              mediaQuery: MediaQuery.of(context).size,
              controller: controller,
              data: data,
            )
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class tabsWithoutIcon extends StatefulWidget {
  const tabsWithoutIcon({
    super.key,
    required this.controller,
    required this.mediaQuery,
    required this.tabs,
  });
  final Size mediaQuery;
  final List<Tab> tabs;
  final TabController? controller;

  @override
  State<tabsWithoutIcon> createState() => _tabsWithoutIconState();
}

// ignore: camel_case_types
class _tabsWithoutIconState extends State<tabsWithoutIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
      padding: const EdgeInsets.only(right: 15, left: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TabBar(controller: widget.controller, tabs: widget.tabs),
    );
  }
}

class SlidesForTabs extends StatelessWidget {
  const SlidesForTabs({
    super.key,
    required this.mediaQuery,
    required this.controller,
    required this.data,
  });

  final Size mediaQuery;
  final TabController? controller;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaQuery.height / 1.3,
      width: double.infinity,
      child: TabBarView(
        controller: controller,
        children: [
          installmentsTab(mediaQuery: mediaQuery, data: data),
          installmentsTab(mediaQuery: mediaQuery, data: data),
          installmentsTab(mediaQuery: mediaQuery, data: data),
        ],
      ),
    );
  }
}
