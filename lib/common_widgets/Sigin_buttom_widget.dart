import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width, size.height);
    path0.cubicTo(
        size.width * 1.0253315,
        size.height * 0.5511111,
        size.width * 0.8550276,
        size.height * 0.3291111,
        size.width * 0.7593094,
        size.height * 0.3313333);
    path0.cubicTo(
        size.width * 0.5848343,
        size.height * 0.3357222,
        size.width * 0.3391436,
        size.height * 0.3317222,
        size.width * 0.1903315,
        size.height * 0.3291111);
    path0.quadraticBezierTo(
        size.width * 0.0311878, size.height * 0.3265556, 0, 0);
    path0.lineTo(0, size.height);
    path0.quadraticBezierTo(size.width * 0.2724033, size.height * 0.9980000,
        size.width, size.height);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ImageClipPathBetter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // double w = size.width;
    // double h = (size.width * 1.1988950276243093).toDouble();

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, size.height * 0.0010138);
    path0.quadraticBezierTo(size.width * 1.0027624, size.height * 0.5505530,
        size.width, size.height * 0.7387327);
    path0.cubicTo(
        size.width * 1.0056354,
        size.height * 0.8529954,
        size.width * 0.8856906,
        size.height * 0.8761290,
        size.width * 0.8564641,
        size.height * 0.8763134);
    path0.cubicTo(
        size.width * 0.5093370,
        size.height * 0.8751613,
        size.width * 0.4824586,
        size.height * 0.8742857,
        size.width * 0.1658840,
        size.height * 0.8760599);
    path0.cubicTo(size.width * 0.1379834, size.height * 0.8766129,
        size.width * 0.0003039, size.height * 0.8770046, 0, size.height);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
