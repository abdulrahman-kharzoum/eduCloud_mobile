import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:educloud_mobile/common_widgets/Sigin_buttom_widget.dart';
import 'package:educloud_mobile/main.dart';
import 'package:educloud_mobile/models/model.dart';
import 'package:educloud_mobile/providers/Model_provider.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:space_fixer/space_fixer.dart';
import 'package:educloud_mobile/providers/onboarding_proivder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: 1,
            ),
            Consumer<OnboardingProvider>(
              builder: (context, value, child) => PageView(
                allowImplicitScrolling: false,
                controller: value.controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Consumer<OnboardingProvider>(
                    builder: (context, value, child) => buildPage(
                      key: ValueKey(6),
                      urlImage: value.currentImagePath,
                      index: value.index,
                      title: value.textWidgets,
                      subtitle: value.subtextsWidgets,
                      size: value.size,
                    ),
                  ),
                  Consumer<OnboardingProvider>(
                    builder: (context, value, child) => buildPage(
                      key: ValueKey(6),
                      urlImage: value.currentImagePath,
                      index: value.index,
                      title: value.textWidgets,
                      subtitle: value.subtextsWidgets,
                      size: value.size,
                    ),
                  ),
                  Consumer<OnboardingProvider>(
                    builder: (context, value, child) => buildPage(
                      key: ValueKey(6),
                      urlImage: value.currentImagePath,
                      index: value.index,
                      title: value.textWidgets,
                      subtitle: value.subtextsWidgets,
                      size: value.size,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              heightFactor: 30,
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 19,
                child: Consumer<OnboardingProvider>(
                  builder: (context, value, child) => SmoothPageIndicator(
                    controller: value.controller,
                    count: 3,
                    effect: SwapEffect(
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.textColor,
                      dotHeight: 20,
                      dotWidth: 20,
                      spacing: 10,
                      // verticalOffset: 50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: CustomPaint(
          size: Size(double.infinity,
              (double.infinity * 0.4696132596685083 - 30).toDouble()),
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
                    // final prefs = await SharedPreferences.getInstance();
                    // prefs.setBool('showLogin', true);

                    // Model _model = new Model();
                    // _model.passwordController = passwordController;
                    // _model.userNameController = userNameController;

                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   // barrierColor: Colors.transparent,
                    //   backgroundColor: Colors.transparent,
                    //   context: context,
                    //   builder: (context) => buildSheet(size, _model),
                    // );
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
  required Key? key,
  required String urlImage,
  required int index,
  required TypewriterAnimatedText title,
  required TypewriterAnimatedText subtitle,
  required Size size,
  // required Size size,
}) =>
    Column(
      children: [
        ClipPath(
          clipper: ImageClipPathBetter(),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Image.asset(
              urlImage,
              key: ValueKey(index),
              fit: BoxFit.cover,
              height: size.height / 1.7,
              width: size.width,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: AnimatedTextKit(
            repeatForever: true,
            key: ValueKey(index),
            pause: Duration(milliseconds: 2000),
            // isRepeatingAnimation: false,
            animatedTexts: [
              title,

              // ScaleAnimatedText('text'),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: AnimatedTextKit(
            repeatForever: true,
            key: ValueKey(index),
            pause: Duration(milliseconds: 2000),
            // isRepeatingAnimation: false,
            animatedTexts: [
              subtitle,

              // ScaleAnimatedText('text'),
            ],
          ),
        ),
      ],
    );
