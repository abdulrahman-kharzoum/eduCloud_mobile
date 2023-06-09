import 'package:educloud_mobile/common_widgets/chartTitile.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<MarksPoints> points;
  final String title;
  const LineChartWidget(this.points, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2, right: 2),
      margin: EdgeInsets.only(left: 2, right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        // border: Border.all(
        //   width: 1.0,
        //   color: Colors.white,
        // ),
        boxShadow: const [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            blurRadius: 9,
            color: Colors.grey,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 10,
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0,
                      blurRadius: 9,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    title,
                    style: AppTextStyles.textTitleStyle,
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.only(top: 10),
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: LineChart(
                    LineChartData(
                      maxX: 7,
                      minX: -0.3,
                      minY: 10,
                      maxY: 100,
                      // baselineX: 30,
                      titlesData: LineTitle.getTitleDate(),
                      gridData: FlGridData(
                        show: false,
                        getDrawingHorizontalLine: ((value) {
                          return FlLine(
                            color: AppColors.secondaryColor,
                            strokeWidth: 1,
                          );
                        }),
                        drawVerticalLine: false,
                        getDrawingVerticalLine: ((value) {
                          return FlLine(
                            color: AppColors.secondaryColor,
                            strokeWidth: 1,
                          );
                        }),
                      ),
                      borderData: FlBorderData(
                        show: false,
                        border:
                            Border.all(color: AppColors.ProfileColor, width: 5),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          barWidth: 3,
                          color: Colors.white,

                          spots: points
                              .map((point) => FlSpot(point.x, point.y))
                              .toList(),
                          isCurved: true,

                          gradient: LinearGradient(
                            colors: AppColors.gradientColors,
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          // color: AppColors.primaryColor,

                          dotData: FlDotData(
                            show: true,
                          ),

                          belowBarData: BarAreaData(
                            color: Colors.white,
                            show: true,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                tileMode: TileMode.clamp,
                                colors: AppColors.gradientColors
                                    .map((color) => color.withOpacity(0.4))
                                    .toList()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
