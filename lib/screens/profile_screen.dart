import 'package:educloud_mobile/common_widgets/BackgroundPaint.dart';
import 'package:educloud_mobile/common_widgets/common_button.dart';
import 'package:educloud_mobile/common_widgets/lineChart.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/models/user.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class ProfileScreen extends StatelessWidget {
  User user = User(
      phone_number: "+963981233473",
      grade_section: "grad 8 / section 2 ",
      fatherName: "Ahmad moshen",
      motherName: "Sara ahmad",
      Address: "39 Iroquios Street Owosso, MI 48867 ");
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: AppColors.iconColor,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.home,
                  color: AppColors.iconColor,
                  size: 20,
                ))
          ],
          elevation: 0,
          backgroundColor: AppColors.ProfileColor,
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Consumer<BaseProvider>(
                    builder: (context, value, child) => CustomPaint(
                      size: Size(value.size.width,
                          (value.size.width * 0.5046851016059932).toDouble()),
                      painter: RPSCustomPainterAppBar(),
                      child: Container(
                        height: 120,
                      ),
                    ),
                  ),
                  Consumer<BaseProvider>(
                    builder: (context, value, child) => Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          // heightFactor: 1.4,
                          alignment: Alignment.center,
                          child: Container(
                            height: 170,
                            width: 170,
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
                            child: CircleAvatar(
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
                ],
              ),
              Container(
                child: Center(
                  child:
                      Text('Student Name', style: AppTextStyles.textTitleStyle),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(top: 5),
                child: Center(
                  child: Text('Grade Number',
                      style: AppTextStyles.textSubTitleStyle
                          .copyWith(fontSize: 14)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        // gradient: LinearGradient(
                        //     colors: [
                        //       AppColors.ProfileColor,
                        //       AppColors.primaryColor
                        //     ],
                        //     begin: Alignment.bottomLeft,
                        //     end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: LineChartWidget(marksPoints, 'Student Situation')),
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
              Common_Button("Subject Info"),
            ],
          ),
        ),
      ),
    );
  }
}

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
