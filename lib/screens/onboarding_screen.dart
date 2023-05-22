import 'dart:math';
import 'package:educloud_mobile/models/model.dart';
import 'package:educloud_mobile/providers/Model_provider.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:space_fixer/space_fixer.dart';
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
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  // final controller = PageController(viewportFraction: 0.9999);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Consumer<OnboardingProvider>(
            builder: (context, onprove, child) {
              return Stack(
                children: [
                  PageView(
                    allowImplicitScrolling: true,
                    physics: AlwaysScrollableScrollPhysics(),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 37.5,
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.teal.shade700),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        bottomSheet: context.watch<OnboardingProvider>().isLastPage
            ? CustomPaint(
                size: Size(size.width,
                    (size.width * 0.4696132596685083 - 30).toDouble()),
                painter: RPSCustomPainter(),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showLogin', true);

                          Model _model = new Model();
                          _model.passwordController = passwordController;
                          _model.userNameController = userNameController;

                          showModalBottomSheet(
                            isScrollControlled: true,
                            // barrierColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => buildSheet(size, _model),
                          );
                        },
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : CustomPaint(
                size: Size(size.width,
                    (size.width * 0.4696132596685083 - 30).toDouble()),
                painter: RPSCustomPainter(),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () => controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
  Widget buildSheet(Size size, Model _model) => makeDismissible(
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          builder: (context, scrollController) => Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              physics: NeverScrollableScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.end,
              // mainAxisSize: MainAxisSize.min,
              children: [
                CustomPaint(
                  size: Size(size.width,
                      (size.width * 0.4696132596685083 - 30).toDouble()),
                  painter: RPSCustomPainter(),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                  height: 2,
                                  thickness: 2,
                                  indent: (size.width / 2) - 40,
                                  endIndent: (size.width / 2) - 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SpaceFixerHorizontalLine(
                  context: context,
                  overflowHeight: 3,
                  overflowColor: AppColors.primaryColor,
                ),
                Container(
                    padding: EdgeInsets.only(top: 25),
                    height: 400,
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 10, 50, 16),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.userNameController,
                              autofocus: true,
                              autofillHints: [AutofillHints.name],
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Enter Name',
                                hintStyle: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E3E7),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4B39EF),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 30.0, horizontal: 20.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                              ),
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF101213),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              keyboardType: TextInputType.name,
                              // validator: _model.emailAddressControllerValidator.asValidator(context),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Consumer<ModelProvider>(
                            builder: (context, value, child) => Container(
                              width: double.infinity,
                              child: TextFormField(
                                obscureText: !value.model.passwordVisibility,
                                controller: _model.passwordController,
                                autofocus: true,
                                autofillHints: [AutofillHints.name],

                                decoration: InputDecoration(
                                  hintText: 'Enter Password',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF101213),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE0E3E7),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF4B39EF),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFFF5963),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 30.0, horizontal: 20.0),
                                  suffixIcon: Consumer<ModelProvider>(
                                    builder: (context, value, child) => InkWell(
                                      onTap: () {
                                        value.model.passwordVisibility
                                            ? value.setFalse_PasswordVisible()
                                            : value.setTrue_PasswordVisible();
                                      },
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Selector<ModelProvider,
                                          ModelProvider>(
                                        selector: (_, modelProvider) =>
                                            modelProvider,
                                        builder: (context, value, child) =>
                                            Icon(
                                          (value.model.passwordVisibility)
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0)),
                                ),

                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                keyboardType: TextInputType.name,
                                // validator: _model
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(50),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 200,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: AppColors.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
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
          Container(
            // height: 220,
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 310,
                  ),
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
