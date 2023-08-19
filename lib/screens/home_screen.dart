import 'dart:ui';
import 'package:educloud_mobile/common_widgets/backgroundPaint.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/screens/suggestions_screen.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../sever/apis.dart';
import '../translations/locale_keys.g.dart';
import '../widgets/advertisemen_container_widget.dart';
import '../widgets/head_profile_widget.dart';
import '../widgets/home_screen_widgets/topic_widget.dart';
import 'chat_gpt.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  // static const routeName = '/home-screen';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //this get the language of the app
  Locale appLocale = window.locale;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudentData();
  }

  Future<void> getStudentData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Apis().studentInfo();
      await Provider.of<Apis>(context, listen: false).studentExpenses();
      await Provider.of<Apis>(context, listen: false).studentExpensesSchool();
      await Provider.of<Apis>(context, listen: false).studentExpensesBuss();
      setState(() {
        for (int i = 0; i < Apis.studentData['data']['marks'].length; i++) {
          print('hello');
          if (Apis.studentData['data']['marks'][i]['type_name'] == 'سبر') {
            print('hi');
            MarksPoints.dataChart2.add(double.parse(
                Apis.studentData['data']['marks'][i]['mark'].toString()));
          }
          if (Apis.studentData['data']['marks'][i]['type_name'] == 'امتحان') {
            MarksPoints.dataChart1.add(double.parse(
                Apis.studentData['data']['marks'][i]['mark'].toString()));
          }
        }
        print('----1----------------213------------------');
        print(MarksPoints.dataChart1);
        print(MarksPoints.dataChart2);
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
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
            extendBodyBehindAppBar: true,
            drawer: const appDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRouter.notificationScreen),
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
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LineChartSample11()),
                                ),
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
                                    context, AppRouter.mark1Screen),
                                child: topicWidget(
                                  screenHight: screenHight,
                                  screenWidth: screenWidth,
                                  topicTitle: LocaleKeys.studentsubjects.tr(),
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
                                    context, AppRouter.installmentsScreen),
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
                                    context, AppRouter.schoolBusSc),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(SuggestionScreen.routeName);
                                  // GoRouter.of(context)
                                  //     .push(AppRouter.suggestionScreen);
                                },
                                child: topicWidget(
                                  screenHight: screenHight,
                                  screenWidth: screenWidth,
                                  topicTitle:
                                      LocaleKeys.suggestionscomplaints.tr(),
                                  widgetP: SvgPicture.asset(
                                      'assets/svg/complaint.svg',
                                      fit: BoxFit.fill),
                                ),
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
