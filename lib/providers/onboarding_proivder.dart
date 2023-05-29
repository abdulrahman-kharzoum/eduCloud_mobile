import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:educloud_mobile/providers/base_provider.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingProvider extends BaseProvider {
  int _currentImageIndex = 0;
  int _currentTextIndex = 0;
  final _controller = PageController();
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
  void stSize(Size ssize) {
    size = ssize;
    notifyListeners();
  }

  OnboardingProvider() {
    Timer.periodic(Duration(seconds: 4), (timer) {
      _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
      _controller.nextPage(
          duration: const Duration(microseconds: 500), curve: Curves.easeInOut);
      // _currentTextIndex = (_currentTextIndex + 1) % _text.length;
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
  PageController get controller => _controller;
  String get currentImagePath => _imagePaths[_currentImageIndex];
  // String get currentTextIndex => _text[_currentTextIndex];
}
