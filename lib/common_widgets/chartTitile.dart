import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitle {
  static getTitleDate() => FlTitlesData(
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 35)),
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 25,
            showTitles: true,
            getTitlesWidget: (value, _) {
              switch (value) {
                case 0:
                  return Text('Sun');
                case 1:
                  return Text('Mon');
                case 2:
                  return Text('Th');
                case 3:
                  return Text('Wed');
                case 4:
                  return Text('TH');
                case 5:
                  return Text('Frd');
                case 6:
                  return Text('Sat');
              }
              return Text('');
            },
          ),
        ),
      );
}
