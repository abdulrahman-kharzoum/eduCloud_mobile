import 'package:collection/collection.dart';

class MarksPoints {
  final double x;
  final double y;
  MarksPoints({required this.x, required this.y});
}

List<MarksPoints> get marksPoints {
  final data = <double>[10, 40, 60, 100, 30, 70, 90];
  return data
      .mapIndexed(
          (((index, element) => MarksPoints(x: index.toDouble(), y: element))))
      .toList();
}
