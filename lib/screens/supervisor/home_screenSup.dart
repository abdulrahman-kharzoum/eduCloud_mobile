import 'dart:ui';
import 'package:educloud_mobile/common_widgets/backgroundPaint.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/screens/suggestions_screen.dart';
import 'package:educloud_mobile/screens/supervisor/head_profile_sup.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:educloud_mobile/widgets/advertisemen_container_widget.dart';
import 'package:educloud_mobile/widgets/app_drawer.dart';
import 'package:educloud_mobile/widgets/bus_screen_widgets/app_drawerSup.dart';
import 'package:educloud_mobile/widgets/home_screen_widgets/topic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class HomeScreenSup extends StatefulWidget {
  // static const routeName = '/home-screen';
  HomeScreenSup({super.key});

  @override
  State<HomeScreenSup> createState() => _HomeScreenSupState();
}

class _HomeScreenSupState extends State<HomeScreenSup> {
  //this get the language of the app
  Locale appLocale = window.locale;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            body: Stack(
              children: [
                CustomPaint(
                  //this for the background
                  size: Size(
                    screenWidth,
                    screenHight,
                    // (screenWidth * 2.1434668500180276)
                    //     .toDouble()
                  ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: Background(),
                ),
                Center(
                  child: Lottie.asset(
                      width: screenWidth / 3, 'assets/lotties/loading.json'),
                )
              ],
            ),
          )
        : Scaffold(
            drawer: const appDrawerSup(),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // automaticallyImplyLeading: false,
              actions: [],
            ),
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      //this for the background
                      size: Size(
                        screenWidth,
                        screenHight,
                        // (screenWidth * 2.1434668500180276)
                        //     .toDouble()
                      ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: Background(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //this head widget for user name and image and grade
                        Container(
                          margin: context.locale.toString() == 'en'
                              ? EdgeInsets.only(
                                  top: screenHight / 17, left: screenWidth / 5)
                              : EdgeInsets.only(
                                  top: screenHight / 17,
                                  right: screenWidth / 5),
                          child: InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AppRouter.profileScreen),
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
                        ),
                        //Advertisements
                        Container(
                          margin: context.locale.toString() == 'en'
                              ? EdgeInsets.only(
                                  left: screenWidth / 20, top: screenHight / 30)
                              : EdgeInsets.only(
                                  right: screenWidth / 20,
                                  top: screenHight / 30),
                          child: Text(
                            LocaleKeys.advertisements.tr(),
                            style: AppTextStyles.profile,
                          ),
                        ),
                        GestureDetector(
                            onTap: () => print(context.locale),
                            child: advertisementesContainerWidget(
                                screenHight: screenHight)),
                        SizedBox(
                          height: screenHight / 10,
                        ),
                        //this container for first tow topic
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth / 70),
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth / 40,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRouter.absencesScreen2),
                                child: topicWidget(
                                  screenHight: screenHight,
                                  screenWidth: screenWidth,
                                  topicTitle: LocaleKeys.absences.tr(),
                                  widgetP: SvgPicture.asset(
                                      'assets/svg/student.svg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 20,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRouter.pricePaidScreen),
                                child: topicWidget(
                                  screenHight: screenHight,
                                  screenWidth: screenWidth,
                                  topicTitle:
                                      LocaleKeys.expensesinstallments.tr(),
                                  widgetP: SvgPicture.asset(
                                      'assets/svg/mony.svg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHight / 19,
                        ),
                        //this container for second tow topic
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth / 70),
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth / 40,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRouter.busSupScreen),
                                child: topicWidget(
                                  screenHight: screenHight,
                                  screenWidth: screenWidth,
                                  topicTitle: LocaleKeys.schoolbuslocation.tr(),
                                  widgetP: SvgPicture.asset(
                                      'assets/svg/bus.svg',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth / 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ));
  }
}
