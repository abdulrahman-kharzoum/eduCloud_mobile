import 'dart:ui' as ui;
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/common_widgets/lineChart.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:educloud_mobile/widgets/markWidget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widgets/BackgroundPaint.dart';
import '../models/Notification.dart';
import '../providers/notification_provider.dart';
import '../routing/app_router.dart';
import '../styles/app_colors.dart';
import '../widgets/head_profile_widget.dart';

// ignore: must_be_immutable
class Mark1Screen extends StatelessWidget {
  Mark1Screen({super.key});
  //this get the language of the app
  Locale appLocale = window.locale;

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.of(context).pop(),
          color: AppColors.secondaryColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Container(
            // ignore: unrelated_type_equality_checks
            //check if the language english or arabic
            margin: context.locale.toString() == 'en'
                ? EdgeInsets.only(right: screenWidth / 40)
                : EdgeInsets.only(left: screenWidth / 40),
            child: Consumer<NotificationProvider>(
              builder: (context, value, child) => GestureDetector(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final String NotificationsString =
                      prefs.getString('notifications_key') ?? '';

                  final List<MyNotification> notifications =
                      MyNotification.decode(NotificationsString);
                  value.setNotifications(notifications);
                  Navigator.pushNamed(context, AppRouter.notificationScreen);
                },
                child: Icon(
                  Icons.notifications,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomPaint(
        //this for the background
        size: Size(
            screenWidth,
            (screenWidth * 2.1434668500180276)
                .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: Background(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //this head widget for user name and image and grade
            Stack(
              children: [
                CustomPaint(
                  child: CustomPaint(
                    size: Size(
                        screenWidth,
                        (screenWidth * 0.6521739130434783)
                            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter(),
                  ),
                ),
                Container(
                  margin: context.locale.toString() == 'en'
                      ? EdgeInsets.only(
                          top: screenHight / 17, left: screenWidth / 5)
                      : EdgeInsets.only(
                          top: screenHight / 17, right: screenWidth / 5),
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
                    nameColor: AppColors.secondaryColor,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 190,
                    ),
                    Center(
                      child: Container(
                        width: screenWidth - 50,
                        child: LineChartWidget(
                            marksPoints, LocaleKeys.studentSituation.tr(), 2.2),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 120,
                  child: Padding(
                    padding: EdgeInsets.only(right: 110, left: 110),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "37",
                              style: AppTextStyles.textTitleStyle
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                            Text(
                              "Arrangement",
                              style: AppTextStyles.miniTitle
                                  .copyWith(color: AppColors.secondaryColor),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Column(
                          children: [
                            Text(
                              "3500",
                              style: AppTextStyles.textTitleStyle
                                  .copyWith(color: AppColors.secondaryColor),
                            ),
                            Text(
                              "Grand total",
                              style: AppTextStyles.miniTitle
                                  .copyWith(color: AppColors.secondaryColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRouter.mark2Screen),
              child: MarkWidget(
                  title: LocaleKeys.examsMarks.tr(),
                  img: "assets/markScreen/examsMarks.jpg",
                  screenWidth: screenWidth),
            ),

            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRouter.mark2Screen),
              child: MarkWidget(
                  title: LocaleKeys.quizzesMarks.tr(),
                  img: "assets/markScreen/quizzesMarks.jpg",
                  screenWidth: screenWidth),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRouter.mark2Screen),
              child: MarkWidget(
                  title: LocaleKeys.teacherNotes.tr(),
                  img: "assets/markScreen/teacherNotes.jpg",
                  screenWidth: screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}

//  [AppColors.ThirdColor, AppColors.primaryColor],
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
    paint_fill_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, size.height * -0.00),
        Offset(size.width * 0.50, size.height * 1.00),
        [AppColors.ThirdColor, AppColors.primaryColor],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0018307, size.height * -0.0018169);
    path_0.lineTo(size.width * -0.0007780, size.height * -0.0044561);
    path_0.quadraticBezierTo(size.width * -0.0024714, size.height * 0.5745642,
        size.width * -0.0022883, size.height * 0.7663362);
    path_0.cubicTo(
        size.width * 0.3386728,
        size.height * 0.9882105,
        size.width * 0.6576659,
        size.height * 0.9957895,
        size.width * 1.0022883,
        size.height * 0.7613028);
    path_0.quadraticBezierTo(size.width * 1.0022883, size.height * 0.5724069,
        size.width * 1.0018307, size.height * -0.0018169);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
