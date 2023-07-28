import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/constants/sharedPreferences.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/screens/settings_screen.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/widgets/head_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routing/app_router.dart';
import '../screens/onboarding_screen.dart';
import '../translations/locale_keys.g.dart';

// ignore: camel_case_types
class appDrawer extends StatefulWidget {
  const appDrawer({super.key});

  @override
  State<appDrawer> createState() => _appDrawerState();
}

// ignore: camel_case_types
class _appDrawerState extends State<appDrawer> {
  bool isExpanded = false;
  Locale appLocale = window.locale;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      // width: screenWidth / 2,
      child: row(mediaQuery),
    );
  }

  Widget row(Size mediaQuery) {
    return Row(
      children: [
        !isExpanded ? startMenuIcon(mediaQuery) : invisibleSubMenu(mediaQuery),
      ],
    );
  }

  Widget startMenuIcon(Size mediaQuery) {
    return Container(
      width: mediaQuery.width / 5,
      color: AppColors.mainColor,
      child: Column(
        children: [
          SizedBox(
            height: mediaQuery.height / 20,
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = true;
                });
              },
              icon: const Icon(
                Icons.format_list_bulleted_rounded,
                color: Colors.white,
                size: 35,
              )),
          SizedBox(
            height: mediaQuery.height / 20,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (Route<dynamic> route) => false),
            child: const circleIconWidget(
              color: Color.fromRGBO(254, 178, 91, 1),
              widget: Icon(
                Icons.home,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 15,
          ),
          const circleIconWidget(
            color: Color.fromRGBO(254, 91, 96, 1),
            widget: Icon(
              Icons.book,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          const circleIconWidget(
            color: Color.fromRGBO(84, 179, 155, 1),
            widget: Icon(
              Icons.local_post_office,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          const circleIconWidget(
            color: Color.fromRGBO(162, 179, 84, 1),
            widget: Icon(
              Icons.directions_bus_rounded,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 5,
          ),
          const Icon(
            Icons.calendar_today_outlined,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(
            height: mediaQuery.height / 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Divider(
              height: 10,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(settingsScreen.routeName);
            },
            child: const circleIconWidget(
              color: Color.fromRGBO(97, 91, 254, 1),
              widget: Icon(
                Icons.settings,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          GestureDetector(
            onTap: () async {
              final _per = await SharedPreferences.getInstance();
              _per.remove(token);
              GoRouter.of(context).push(AppRouter.onBoardingScreen);
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingScreen(),
                ),
              );*/
            },
            child: const circleIconWidget(
              color: Color.fromRGBO(97, 91, 254, 1),
              widget: Icon(
                Icons.logout,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget invisibleSubMenu(Size mediaQuery) {
    return Container(
      padding: context.locale.toString() == 'en'
          ? EdgeInsets.only(left: mediaQuery.width / 20)
          : EdgeInsets.only(right: mediaQuery.width / 20),
      width: mediaQuery.width / 1.5,
      color: AppColors.mainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mediaQuery.height / 20,
          ),
          headProfileWidget(
            screenHight: mediaQuery.width,
            screenWidth: mediaQuery.height,
            nameColor: Colors.white,
          ),
          SizedBox(
            height: mediaQuery.height / 20,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName, (Route<dynamic> route) => false),
            child: circleIconWidget2(
              iconName: LocaleKeys.homepage.tr(),
              mediaQuery: mediaQuery,
              color: const Color.fromRGBO(254, 178, 91, 1),
              widget: const Icon(
                Icons.home,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 15,
          ),
          circleIconWidget2(
            iconName: LocaleKeys.studentsubjects.tr(),
            mediaQuery: mediaQuery,
            color: const Color.fromRGBO(254, 91, 96, 1),
            widget: const Icon(
              Icons.book,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          circleIconWidget2(
            iconName: LocaleKeys.messagesnotifications.tr(),
            mediaQuery: mediaQuery,
            color: const Color.fromRGBO(84, 179, 155, 1),
            widget: const Icon(
              Icons.local_post_office,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          circleIconWidget2(
            iconName: LocaleKeys.schoolbuslocation.tr(),
            mediaQuery: mediaQuery,
            color: const Color.fromRGBO(162, 179, 84, 1),
            widget: const Icon(
              Icons.directions_bus_rounded,
              color: Colors.white,
              size: 25,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 5,
          ),
          Container(
            margin: EdgeInsets.only(left: mediaQuery.width / 40),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  width: mediaQuery.width / 20,
                ),
                Text(
                  LocaleKeys.calender.tr(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Euclid Circular A'),
                )
              ],
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 20,
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Divider(
              height: 10,
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(settingsScreen.routeName);
            },
            child: circleIconWidget2(
              iconName: LocaleKeys.settings.tr(),
              mediaQuery: mediaQuery,
              color: const Color.fromRGBO(97, 91, 254, 1),
              widget: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          GestureDetector(
            onTap: () async {
              final _per = await SharedPreferences.getInstance();
              _per.remove(token);
              GoRouter.of(context).push(AppRouter.onBoardingScreen);
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OnboardingScreen(),
                ),
              );*/
            },
            child: circleIconWidget2(
              iconName: LocaleKeys.logout.tr(),
              mediaQuery: mediaQuery,
              color: const Color.fromRGBO(97, 91, 254, 1),
              widget: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class circleIconWidget extends StatelessWidget {
  const circleIconWidget({
    super.key,
    required this.color,
    required this.widget,
  });

  final Color color;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(child: widget),
    );
  }
}

// ignore: camel_case_types
class circleIconWidget2 extends StatelessWidget {
  const circleIconWidget2({
    super.key,
    required this.color,
    required this.widget,
    required this.mediaQuery,
    required this.iconName,
  });

  final Color color;
  final Widget widget;
  final Size mediaQuery;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(child: widget),
          ),
          SizedBox(
            width: mediaQuery.width / 20,
          ),
          Text(
            iconName,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Euclid Circular A'),
          )
        ],
      ),
    );
  }
}
