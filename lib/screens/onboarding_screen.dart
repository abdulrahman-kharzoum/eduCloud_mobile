import 'dart:math';

import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:educloud_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:ui' as ui;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Consumer<OnboardingProvider>(
                builder: (context, onprove, child) {
                  return Stack(
                    children: [
                      Expanded(
                        flex: 1,
                        child: PageView(
                          onPageChanged: (index) {
                            if (index == 2) {
                              onprove.islastpage_true();
                            } else {
                              onprove.islastpage_false();
                            }
                          },
                          controller: controller,
                          children: [
                            buildPage(
                              color: Colors.white,
                              urlImage: 'images/onboardingScreen/1.jpeg',
                              title: 'Page 1',
                              subtitle: 'Hello world',
                              size: size,
                            ),
                            buildPage(
                              color: Colors.white,
                              urlImage: 'images/onboardingScreen/2.jpeg',
                              title: 'Page 2',
                              subtitle: 'Hello world',
                              size: size,
                            ),
                            buildPage(
                              color: Colors.white,
                              urlImage: 'images/onboardingScreen/3.jpg',
                              title: 'Page 3',
                              subtitle: 'Hello world',
                              size: size,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 37.5,
                        child: Container(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: WormEffect(
                                spacing: 16,
                                dotColor: Colors.black26,
                                activeDotColor: Colors.teal.shade700),
                            onDotClicked: (index) => controller.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          bottomSheet: context.watch<OnboardingProvider>().isLastPage
              ? GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showLogin', true);

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: CustomPaint(
                    size: Size(size.width,
                        (size.width * 0.4696132596685083 - 30).toDouble()),
                    painter: RPSCustomPainter(),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Sgin In',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                  child: CustomPaint(
                    size: Size(size.width,
                        (size.width * 0.4696132596685083 - 30).toDouble()),
                    painter: RPSCustomPainter(),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}

Widget buildPage({
  required Color color,
  required String urlImage,
  required String title,
  required String subtitle,
  required var size,
}) =>
    Container(
      color: color,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPathBetter(),
            child: Image(
              image: AssetImage(urlImage),
              fit: BoxFit.cover,
              height: 480,
              width: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 220,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.teal.shade700,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      subtitle,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
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

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height * 0.5995200);
    path0.quadraticBezierTo(size.width * 0.9393000, size.height * 0.7992200,
        size.width * 0.8136000, size.height * 0.7986400);
    path0.quadraticBezierTo(size.width * 0.6893125, size.height * 0.7990400,
        size.width * 0.3769375, size.height * 0.8033600);
    path0.quadraticBezierTo(size.width * 0.3808250, size.height * 0.8015000,
        size.width * 0.1883875, size.height * 0.7993200);
    path0.quadraticBezierTo(
        size.width * 0.0628500, size.height * 0.8000600, 0, size.height);
    path0.lineTo(0, 0);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipPathBetter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = (size.width * 1.1988950276243093).toDouble();

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

class CustomClipPathBouttom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = (size.width * 0.5524861878453039).toDouble();

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

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
