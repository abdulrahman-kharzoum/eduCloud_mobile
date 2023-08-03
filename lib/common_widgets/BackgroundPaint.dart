import 'package:flutter/material.dart';
import 'dart:ui' as ui;

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*2.1434668500180276).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 1.211936, size.height * -0.05497095);
    path_0.cubicTo(
        size.width * 1.453588,
        size.height * -0.03541289,
        size.width * 1.116775,
        size.height * -0.07823747,
        size.width * 1.116775,
        size.height * -0.07823747);
    path_0.cubicTo(
        size.width * 1.136798,
        size.height * -0.07823747,
        size.width * 1.100337,
        size.height * 0.005172800,
        size.width * 1.100337,
        size.height * 0.01634641);
    path_0.lineTo(size.width * 1.131770, size.height * 1.027769);
    path_0.cubicTo(
        size.width * 1.131770,
        size.height * 1.038943,
        size.width * 1.105653,
        size.height * 1.027769,
        size.width * 1.085630,
        size.height * 1.027769);
    path_0.lineTo(size.width * 0.03420789, size.height * 1.017653);
    path_0.cubicTo(
        size.width * 0.01418458,
        size.height * 1.017653,
        size.width * 0.03420789,
        size.height * 1.028827,
        size.width * 0.03420789,
        size.height * 1.017653);
    path_0.cubicTo(
        size.width * 0.03420789,
        size.height * 1.017653,
        size.width * 0.5181493,
        size.height * 1.064777,
        size.width * 0.6369643,
        size.height * 0.8515835);
    path_0.cubicTo(
        size.width * 0.7557793,
        size.height * 0.6383903,
        size.width * 0.2317802,
        size.height * 0.2707616,
        size.width * 0.4956356,
        size.height * 0.05916839);
    path_0.cubicTo(
        size.width * 0.6360671,
        size.height * -0.04552899,
        size.width * 0.9702837,
        size.height * -0.07452771,
        size.width * 1.211936,
        size.height * -0.05497095);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.01000000, size.height * 0.08400000),
        Offset(size.width * 0.6380000, size.height * 0.8150000), [
      Color(0xfffea64c).withOpacity(0.149),
      Color(0xfffe1e9a).withOpacity(0.15),
      Color(0xff254dde).withOpacity(0.15)
    ], [
      0,
      0.372,
      1
    ]);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 1.005565, size.height * 0.0005215831);
    path_1.lineTo(size.width * 1.005565, 0);
    path_1.cubicTo(
        size.width * 1.024780,
        0,
        size.width * 1.044136,
        size.height * 0.009406751,
        size.width * 1.044136,
        size.height * 0.02100937);
    path_1.lineTo(size.width * 1.078631, size.height * 1.012132);
    path_1.cubicTo(
        size.width * 1.078631,
        size.height * 1.023737,
        size.width * 1.076675,
        size.height * 1.044872,
        size.width * 1.057465,
        size.height * 1.044872);
    path_1.lineTo(size.width * 0.0003074489, size.height * 1.049076);
    path_1.cubicTo(
        size.width * -0.01890811,
        size.height * 1.049076,
        size.width * 0.0003074489,
        size.height * 1.060681,
        size.width * 0.0003074489,
        size.height * 1.049076);
    path_1.lineTo(size.width * 0.0003074489, size.height * 0.8023891);
    path_1.cubicTo(
        size.width * 0.004077891,
        size.height * 0.5224372,
        size.width * 0.4580542,
        size.height * 0.5020746,
        size.width * 0.7315608,
        size.height * 0.3449073);
    path_1.cubicTo(
        size.width * 0.9508305,
        size.height * 0.2189045,
        size.width * 0.9970317,
        size.height * 0.0005215831,
        size.width * 1.005565,
        size.height * 0.0005215831);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.01000000, size.height * 0.08400000),
        Offset(size.width * 0.6380000, size.height * 0.8150000),
        [Color(0xff181743).withOpacity(0), Color(0xff254dde).withOpacity(0.2)],
        [0, 1]);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
