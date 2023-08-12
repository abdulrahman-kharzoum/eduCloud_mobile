import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/app_colors.dart';

// ignore: camel_case_types
class advertisementesContainerWidget extends StatelessWidget {
  const advertisementesContainerWidget({
    super.key,
    required this.screenHight,
  });

  final double screenHight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      height: screenHight / 5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.titleTextColor,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 0.01,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: const FadeImageAnimation(
        imagePaths: [
          'assets/svg/show1.svg',
          'assets/svg/show2.svg',
        ],
      ),
    );
  }
}

class FadeImageAnimation extends StatefulWidget {
  final List<String> imagePaths;
  final int durationInMilliseconds;

  const FadeImageAnimation({
    super.key,
    required this.imagePaths,
    this.durationInMilliseconds = 2000,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FadeImageAnimationState createState() => _FadeImageAnimationState();
}

class _FadeImageAnimationState extends State<FadeImageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _fadeOutAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    print(
        "init state----------------------------------------------------------------");
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _fadeOutAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.addStatusListener((status) {
      Future.delayed(const Duration(seconds: 4)).then((value) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _currentIndex = (_currentIndex + 1) % widget.imagePaths.length;
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    print(
        "dispose---------------------------------------------------------------");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Opacity(
              opacity: _fadeOutAnimation.value,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: SvgPicture.asset(widget.imagePaths[_currentIndex],
                    fit: BoxFit.fill),
              ),
            ),
            Opacity(
              opacity: _fadeInAnimation.value,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: SvgPicture.asset(
                    widget.imagePaths[
                        (_currentIndex + 1) % widget.imagePaths.length],
                    fit: BoxFit.fill),
              ),
            ),
          ],
        );
      },
    );
  }
}
