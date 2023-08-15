import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/common_widgets/common_button.dart';
import 'package:educloud_mobile/common_widgets/lineChart.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/models/user.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../routing/app_router.dart';
import '../sever/apis.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  User user = User(
      phone_number: Apis.studentData['data']['numbers'].isEmpty
          ? 'No phone numbers'
          : Apis.studentData['data']['numbers'].first,
      grade_section: Apis.studentData['data']['grade'] != null
          ? "${LocaleKeys.grade.tr()} ${Apis.studentData['data']['grade']}/${Apis.studentData['data']['g_class']['name']}"
          : "${LocaleKeys.grade.tr()} null/${Apis.studentData['data']['g_class']['name']}",
      fatherName: Apis.studentData['data']['father_name'],
      motherName: Apis.studentData['data']['mother_name'],
      Address: Apis.studentData['data']['address']);
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              GradientAppBar(),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Center(
                  child: Text(Apis.studentData['data']['full_name'],
                      style: AppTextStyles.textTitleStyle),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(top: 5),
                child: Center(
                  child: Apis.studentData['data']['grade'] != null
                      ? Text(
                          '${LocaleKeys.grade.tr()} ${Apis.studentData['data']['grade']}',
                          style: AppTextStyles.textSubTitleStyle
                              .copyWith(fontSize: 14))
                      : Text('${LocaleKeys.grade} null',
                          style: AppTextStyles.textSubTitleStyle
                              .copyWith(fontSize: 14)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 25),
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: LineChartWidget(
                          marksPoints, LocaleKeys.studentSituation.tr(), 2.7)),
                ),
              ),
              Container(
                height: 320,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5, // Replace with your actual item count
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 1,
                      shadowColor: Colors.grey,
                      color: AppColors.InfoCardColor,
                      child: user.info_cards[index],
                    );
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                      child: Common_Button(
                    text: LocaleKeys.subjectInfo.tr(),
                    onTap: () {},
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class InfoCard extends StatelessWidget {
  String lead_title;
  String trail_title;
  IconData icon;
  InfoCard(this.lead_title, this.trail_title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        width: 150,
        child: Text(
          trail_title,
          softWrap: true,
          style: AppTextStyles.textTitleStyle.copyWith(fontSize: 16),
        ),
      ),
      leading: Icon(
        icon,
        color: AppColors.primaryColor,
      ),
      title: Text(
        lead_title,
        style: AppTextStyles.textTitleStyle.copyWith(fontSize: 16),
      ), // Replace with your actual item title
      // Replace with your actual item description
      onTap: () {
        // Handle item tap
      },
    );
  }
}

class RPSCustomPainterAppBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    size = Size(size.width + 10, size.height + 25);
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(220, 34, 62, 109)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
    paint_fill_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, size.height * 0.50),
        Offset(size.width * 0.50, size.height * 0.50),
        [Color.fromRGBO(34, 62, 109, 1), Color.fromRGBO(59, 103, 176, 1)],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0017704);
    path_0.lineTo(size.width * 0.0000000, size.height * 0.9982750);
    path_0.lineTo(size.width * 0.9988774, size.height * 0.5886518);
    path_0.lineTo(size.width * 0.9988774, size.height * -0.0003178);
    path_0.lineTo(0, size.height * 0.0017704);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1 Copy

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(255, 34, 62, 109)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * -0.0011226, size.height * -0.0708611);
    path_1.lineTo(size.width * -0.0011226, size.height * 0.9256435);
    path_1.lineTo(size.width * 0.9977548, size.height * 0.5160470);
    path_1.lineTo(size.width * 0.9977548, size.height * -0.0729493);
    path_1.lineTo(size.width * -0.0011226, size.height * -0.0708611);
    path_1.close();

    canvas.drawPath(path_1, paint_fill_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainterProfile extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1
    size = Size(size.width + 10, size.height);
    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 64, 72, 130)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9977064, size.height * 0.0960000);
    path_0.lineTo(0, size.height * 0.1000000);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width * 0.9977064, size.height * 0.5760000);
    path_0.lineTo(size.width * 0.9977064, size.height * 0.0960000);
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

    // Layer 1 Copy

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(255, 34, 62, 109)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
    paint_fill_1.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, 0),
        Offset(size.width * 0.50, size.height * 0.90),
        [Color(0xff23406f), Color(0xff4583d8)],
        [0.00, 1.00]);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9977064, 0);
    path_1.lineTo(0, size.height * 0.0040000);
    path_1.lineTo(0, size.height * 0.9040000);
    path_1.lineTo(size.width * 0.9977064, size.height * 0.4800000);
    path_1.lineTo(size.width * 0.9977064, 0);
    path_1.close();

    canvas.drawPath(path_1, paint_fill_1);

    // Layer 1 Copy

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class GradientAppBar extends StatelessWidget {
  final double barHeight = 200.0;

  GradientAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Stack(
        children: [
          Consumer<BaseProvider>(
            builder: (context, value, child) => Positioned(
              height: 200,
              width: 500,
              bottom: 5,
              right: 1,
              child: CustomPaint(
                size: Size(value.size.width,
                    (value.size.width * 0.5046851016059932).toDouble()),
                painter: RPSCustomPainterProfile(),
                child: Container(
                  height: 175,
                ),
              ),
            ),
          ),
          Consumer<BaseProvider>(
            builder: (context, value, child) => Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Align(
                  // heightFactor: 1.4,
                  alignment: Alignment.center,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(
                      //       "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=735&q=80"),
                      // ),
                    ),
                    child: const CircleAvatar(
                      radius: 150 / 2,
                      //   backgroundColor: Colors.grey.shade800,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=735&q=80",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRouter.homeScreen, (Route<dynamic> route) => false);
                },
                child: Icon(
                  Icons.home,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
