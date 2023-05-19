import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: PageView(
              controller: controller,
              children: [
                buildPage(
                    color: Colors.green,
                    urlImage: 'images/onboardingScreen/1.jpeg',
                    title: 'Page 1',
                    subtitle: 'Hello world'),
                buildPage(
                    color: Colors.green,
                    urlImage: 'images/onboardingScreen/2.jpeg',
                    title: 'Page 2',
                    subtitle: 'Hello world'),
                buildPage(
                    color: Colors.green,
                    urlImage: 'images/onboardingScreen/3.jpg',
                    title: 'Page 3',
                    subtitle: 'Hello world'),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => controller.jumpToPage(2),
                child: const Text('SKIP'),
              ),
              Center(
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
              TextButton(
                onPressed: () => controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
                child: const Text('NEXT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildPage({
  required Color color,
  required String urlImage,
  required String title,
  required String subtitle,
}) =>
    Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(urlImage, fit: BoxFit.cover, width: double.infinity),
          const SizedBox(height: 64),
          Text(
            title,
            style: TextStyle(
              color: Colors.teal.shade700,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              subtitle,
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
