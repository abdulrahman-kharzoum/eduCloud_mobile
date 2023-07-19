import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/services/user_services.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingProvider extends BaseProvider {
  int _currentImageIndex = 0;

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  late PageController _controller;
  PageController get controller => this._controller;

  void setcontroller(PageController value) {
    this._controller = value;
    // notifyListeners();
  }

  AutovalidateMode get autovalidateMode => _autovalidateMode;
  void autovalidateModetrue() {
    this._autovalidateMode = AutovalidateMode.always;
    notifyListeners();
  }

  List<String> _imagePaths = [
    'images/onboardingScreen/1.jpeg',
    'images/onboardingScreen/2.jpeg',
    'images/onboardingScreen/3.jpg',
  ];
  List<String> _text = [
    'Page Title 1',
    'Page Title 2',
    'Page Title 3',
  ];
  List<String> _subtext = [
    'Sub Title 1',
    'Sub Title 2',
    'Sub Title 3',
  ];
  late TypewriterAnimatedText _textsWidgets;
  late TypewriterAnimatedText _subtextsWidgets;
  late Timer timer;
  void stSize(Size ssize) {
    size = ssize;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    timer.cancel();
    super.dispose();
  }

  int getCurrentPageIndex(PageController controller) {
    final int? currentPage = controller.page?.toInt();

    return currentPage!;
  }

  void changeController() {
    if (getCurrentPageIndex(_controller) == 2) {
      // _controller.jumpToPage(0);
      _controller.animateToPage(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _controller.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  OnboardingProvider() {
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      changeController();

      // currentPage = nextPage();
      // _controller = PageController(initialPage: currentPage);

      notifyListeners();
    });
  }
  TypewriterAnimatedText get textWidgets =>
      _textsWidgets = TypewriterAnimatedText(
        _text[_currentImageIndex],
        textStyle: AppTextStyles.textTitleStyle,
        //duration: Duration(seconds: 2),
        // scalingFactor: 4,
        speed: Duration(milliseconds: 100),
      );
  TypewriterAnimatedText get subtextsWidgets =>
      _subtextsWidgets = TypewriterAnimatedText(
        _subtext[_currentImageIndex],
        textStyle: AppTextStyles.textSubTitleStyle,
        //duration: Duration(seconds: 2),
        // scalingFactor: 4,
        speed: Duration(milliseconds: 100),
      );
  // PageController get controller => _controller;
  int get index => _currentImageIndex;
  // IndicatorEffect get effect => _effect;
  // PageController get controller => _controller;
  String get currentImagePath => _imagePaths[_currentImageIndex];
}
