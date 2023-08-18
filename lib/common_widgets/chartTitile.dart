import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitle {
  static getTitleDate() => FlTitlesData(
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 25,
            showTitles: true,
            getTitlesWidget: (value, _) {
              switch (value) {
                case 0:
                  return Text('1st');
                case 1:
                  return Text('2nd');
                case 2:
                  return Text('3rd');
                case 3:
                  return Text('4th');
                case 4:
                  return Text('5th');
                case 5:
                  return Text('6th');
                case 6:
                  return Text('7th');
                case 7:
                  return Text('8th');
                case 8:
                  return Text('9th');
                case 9:
                  return Text('10th');
                case 10:
                  return Text('11th');
                case 11:
                  return Text('12th');
                case 12:
                  return Text('13th');
                case 13:
                  return Text('14th');
                case 14:
                  return Text('15th');
                case 15:
                  return Text('16th');
                case 16:
                  return Text('17th');
                case 17:
                  return Text('18th');
                case 18:
                  return Text('19th');
                case 19:
                  return Text('20th');
                case 20:
                  return Text('21st');
                case 21:
                  return Text('22nd');
                case 22:
                  return Text('23rd');
                case 23:
                  return Text('24th');
                case 24:
                  return Text('25th');
                case 25:
                  return Text('26th');
                case 26:
                  return Text('27th');
                case 27:
                  return Text('28th');
                case 28:
                  return Text('29th');
                case 29:
                  return Text('30th');
                case 30:
                  return Text('31st');
              }
              return Text('');
            },
          ),
        ),
      );
}
