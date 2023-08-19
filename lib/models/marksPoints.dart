import 'package:collection/collection.dart';

class MarksPoints {
  final double x;
  final double y;
  MarksPoints({required this.x, required this.y});

  static List<double> dataChart1 = [];
  static List<double> dataChart2 = [];

  static List<MarksPoints> marksPoints() {
    List<double> data = dataChart1;
    return data
        .mapIndexed((((index, element) =>
            MarksPoints(x: index.toDouble(), y: element))))
        .toList();
  }

  static List<MarksPoints> marksPoints2() {
    List<double> data = dataChart2;
    return data
        .mapIndexed((((index, element) =>
            MarksPoints(x: index.toDouble(), y: element))))
        .toList();
  }
}
