import 'package:educloud_mobile/common_widgets/BackgroundPaint.dart';
import 'package:educloud_mobile/common_widgets/lineChart.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/screens/home_screen.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double bg_width = 500;
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
        body: CustomPaint(
          size: Size(
              bg_width,
              (bg_width * 2.1434668500180276)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically

          painter: Background(),
          child: Column(
            children: [
              Stack(
                children: [
                  Consumer<BaseProvider>(
                    builder: (context, value, child) => CustomPaint(
                      size: Size(value.size.width,
                          (value.size.width * 0.5549495668058684).toDouble()),
                      painter: RPSCustomPainterAppBar(),
                      // child: Container(
                      //   height: 150,
                      //   width: 30,
                      //   // child: ,
                      //   // color: Colors.brown,
                      // ),
                    ),
                  ),
                  Consumer<BaseProvider>(
                    builder: (context, value, child) => Align(
                      alignment: Alignment.bottomCenter,
                      // right: value.size.width / 2,
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
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Center(
                  child:
                      Text('Student Name', style: AppTextStyles.textTitleStyle),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Center(
                  child: Text('Grade Number',
                      style: AppTextStyles.textSubTitleStyle),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
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
              // Container(
              //   height: 250,
              //   // width: 400,
              //   // color: AppColors.secondaryColor,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: AppColors.primaryColor),
              //   child: LineChart(
              //     LineChartData(
              //       minX: 0,
              //       maxX: 11,
              //       maxY: 6,
              //       minY: 0,
              //       gridData: FlGridData(
              //         show: true,
              //       ),
              //       lineBarsData: [
              //         LineChartBarData(
              //           spots: [
              //             FlSpot(0, 3),
              //             FlSpot(2.6, 2),
              //             FlSpot(4.9, 5),
              //             FlSpot(6.8, 2.5),
              //             FlSpot(8, 4),
              //             FlSpot(9.5, 3),
              //             FlSpot(11, 4),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*0.5549495668058684).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainterAppBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 3.686432, size.height * 0.05538983);
    path_0.lineTo(size.width * 3.686432, size.height * 0.9506754);
    path_0.lineTo(size.width * 4.644798, size.height * 0.5507569);
    path_0.lineTo(size.width * 4.644798, size.height * 0.05538983);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5000000, 0),
        Offset(size.width * 0.5000000, size.height * 0.01000000),
        [Color(0xff223e6d).withOpacity(1), Color(0xff3b67b0).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 3.686432, size.height * 0.05538983);
    path_1.lineTo(size.width * 3.686432, size.height * 0.9506754);
    path_1.lineTo(size.width * 4.644798, size.height * 0.5507569);
    path_1.lineTo(size.width * 4.644798, size.height * 0.05538983);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5000000, 0),
        Offset(size.width * 0.5000000, size.height * 0.01000000),
        [Color(0xff223e6d).withOpacity(1), Color(0xff3b67b0).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
