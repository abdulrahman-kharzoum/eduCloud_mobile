import 'package:collection/collection.dart';
import 'package:educloud_mobile/models/mark.dart';

class MarksPoints {
  final double x;
  final double y;
  MarksPoints({required this.x, required this.y});

  static List<double> dataChart1 = [];

  static List<MarksPoints> marksPoints() {
    return Marks.marks
        .mapIndexed((((index, element) => MarksPoints(
            x: index.toDouble(), y: double.parse(element['mark'].toString())))))
        .toList();
  }
}
