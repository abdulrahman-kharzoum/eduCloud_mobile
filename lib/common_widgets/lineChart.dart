import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/common_widgets/chartTitile.dart';
import 'package:educloud_mobile/models/mark.dart';
import 'package:educloud_mobile/models/marksPoints.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:collection/collection.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  final List<MarksPoints> points;
  final String title;
  final double aspectRatio;

  const LineChartWidget(this.points, this.title, this.aspectRatio, {super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  int chartStatus = 0;
  String selectedMark = '';
  String selectedSubject = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Marks.data);
    print(Marks.marksType);
    print(Marks.subjectsName);
    selectedMark = Marks.marksType.first;
    selectedSubject = Marks.subjectsName.first;
  }

  bool _isLoading = false;
  Future<void> getMarks() async {
    try {
      setState(() {
        if (selectedMark != LocaleKeys.all.tr()) {
          selectedSubject == LocaleKeys.all.tr()
              ? Marks.marks = Marks.data
                  .where((element) => element['type_name'] == selectedMark)
                  .toList()
              : Marks.marks = Marks.data
                  .where((element) =>
                      element['type_name'] == selectedMark &&
                      element['subject_name'] == selectedSubject)
                  .toList();
        } else {
          selectedSubject == LocaleKeys.all.tr()
              ? Marks.marks = Marks.data
              : Marks.marks = Marks.data
                  .where(
                      (element) => element['subject_name'] == selectedSubject)
                  .toList();
        }
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMarks(),
      builder: (context, snapshot) => Container(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.marks.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedMark,
                        onChanged: (value) {
                          setState(() {
                            selectedMark = value!;
                            getMarks();
                            print(Marks.marks);
                          });
                        },
                        items: Marks.marksType.map((mark) {
                          return DropdownMenuItem<String>(
                            value: mark,
                            child: Text(mark),
                          );
                        }).toList(),
                      ),
                      Text(
                        LocaleKeys.subjects.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedSubject,
                        onChanged: (value) {
                          setState(() {
                            selectedSubject = value!;
                            print(selectedSubject);
                            getMarks();
                            print(Marks.marks);
                          });
                        },
                        items: Marks.subjectsName.map((subject) {
                          return DropdownMenuItem<String>(
                            value: subject,
                            child: Text(subject),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(top: 10),
                  margin: const EdgeInsets.only(top: 10),
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
                              getTouchedSpotIndicator:
                                  (LineChartBarData barData,
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
                          lineBarsData: <LineChartBarData>[
                            LineChartBarData(
                              barWidth: 3,
                              color: Colors.red,
                              spots: Marks.marks
                                  .mapIndexed((((index, element) => MarksPoints(
                                      x: index.toDouble(),
                                      y: double.parse(
                                          element['mark'].toString())))))
                                  .toList()
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
                                        .map((color) => color.withOpacity(0.4))
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
      ),
    );
  }
}
