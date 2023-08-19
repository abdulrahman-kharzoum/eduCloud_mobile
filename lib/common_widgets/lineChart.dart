import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/common_widgets/chartTitile.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  final List<MarksPoints> points;
  final List<MarksPoints> points2;
  final String title;
  final double aspectRatio;

  const LineChartWidget(this.points, this.points2, this.title, this.aspectRatio,
      {super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  int chartStatus = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 265,
      // padding: EdgeInsets.only(left: 2, right: 2),
      // margin: EdgeInsets.only(left: 2, right: 2),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //quizzes
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        chartStatus = 0;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 0,
                            blurRadius: 4,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          LocaleKeys.quizzes.tr(),
                          style: AppTextStyles.textTitleStyle.copyWith(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 40,
                  ),
                  //exams
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        chartStatus = 1;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 0,
                            blurRadius: 4,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          LocaleKeys.exams.tr(),
                          style: AppTextStyles.textTitleStyle.copyWith(
                              fontSize: 16,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 40,
                  ),
                  //all
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        chartStatus = 2;
                      });
                    },
                    child: Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width / 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            blurStyle: BlurStyle.outer,
                            spreadRadius: 0,
                            blurRadius: 4,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          LocaleKeys.all.tr(),
                          style: AppTextStyles.textTitleStyle.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  aspectRatio: widget.aspectRatio,
                  child: LineChart(
                    swapAnimationDuration:
                        Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                    LineChartData(
                        // maxX: 50,
                        minX: -0.5,
                        minY: 0,
                        maxY: 100,
                        // baselineX: 30,
                        titlesData: LineTitle.getTitleDate(),
                        lineTouchData: LineTouchData(
                            enabled: true,
                            touchCallback: (FlTouchEvent event,
                                LineTouchResponse? touchResponse) {
                              // TODO : Utilize touch event here to perform any operation
                            },
                            touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.blue,
                              tooltipRoundedRadius: 30.0,
                              // showOnTopOfTheChartBoxArea: true,
                              // fitInsideHorizontally: true,
                              // tooltipMargin: 0,
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map(
                                  (LineBarSpot touchedSpot) {
                                    const textStyle = TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    );
                                    return LineTooltipItem(
                                        widget.points[touchedSpot.spotIndex].y
                                            .toStringAsFixed(1),
                                        textStyle,
                                        children: [
                                          TextSpan(
                                              text:
                                                  '\n${widget.points[touchedSpot.spotIndex].x.toStringAsFixed(0)}',
                                              style: textStyle),
                                        ]);
                                  },
                                ).toList();
                              },
                            ),
                            getTouchedSpotIndicator: (LineChartBarData barData,
                                List<int> indicators) {
                              return indicators.map(
                                (int index) {
                                  final line = FlLine(
                                      color: Colors.grey,
                                      strokeWidth: 1,
                                      dashArray: [2, 4]);
                                  return TouchedSpotIndicatorData(
                                    line,
                                    FlDotData(show: false),
                                  );
                                },
                              ).toList();
                            },
                            getTouchLineEnd: (_, __) => double.infinity),
                        borderData: FlBorderData(
                          show: false,
                          border: Border.all(
                              color: AppColors.ProfileColor, width: 5),
                        ),
                        lineBarsData: chartStatus == 0
                            ? <LineChartBarData>[
                                LineChartBarData(
                                  barWidth: 3,
                                  color: Colors.red,
                                  spots: widget.points2
                                      .map((point) => FlSpot(point.x, point.y))
                                      .toList(),
                                  isCurved: true,
                                  belowBarData: BarAreaData(
                                    // color: Colors.red,
                                    show: true,
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        tileMode: TileMode.clamp,
                                        colors: AppColors.gradientColors2
                                            .map((color) =>
                                                color.withOpacity(0.4))
                                            .toList()),
                                  ),
                                ),
                              ]
                            : chartStatus == 1
                                ? <LineChartBarData>[
                                    LineChartBarData(
                                      barWidth: 3,
                                      color: AppColors.appColor,
                                      spots: widget.points
                                          .map((point) =>
                                              FlSpot(point.x, point.y))
                                          .toList(),
                                      isCurved: true,
                                      belowBarData: BarAreaData(
                                        // color: Colors.red,
                                        show: true,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.clamp,
                                            colors: AppColors.gradientColors1
                                                .map((color) =>
                                                    color.withOpacity(0.4))
                                                .toList()),
                                      ),
                                    ),
                                  ]
                                : <LineChartBarData>[
                                    LineChartBarData(
                                      barWidth: 3,
                                      color: AppColors.appColor,
                                      spots: widget.points
                                          .map((point) =>
                                              FlSpot(point.x, point.y))
                                          .toList(),
                                      isCurved: true,
                                      belowBarData: BarAreaData(
                                        // color: Colors.red,
                                        show: true,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.clamp,
                                            colors: AppColors.gradientColors1
                                                .map((color) =>
                                                    color.withOpacity(0.4))
                                                .toList()),
                                      ),
                                    ),
                                    LineChartBarData(
                                      barWidth: 3,
                                      color: Colors.red,
                                      spots: widget.points2
                                          .map((point) =>
                                              FlSpot(point.x, point.y))
                                          .toList(),
                                      isCurved: true,
                                      belowBarData: BarAreaData(
                                        // color: Colors.red,
                                        show: true,
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            tileMode: TileMode.clamp,
                                            colors: AppColors.gradientColors2
                                                .map((color) =>
                                                    color.withOpacity(0.4))
                                                .toList()),
                                      ),
                                    ),
                                  ]),
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
