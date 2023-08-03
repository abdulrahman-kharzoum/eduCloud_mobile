import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../translations/locale_keys.g.dart';

// ignore: camel_case_types
class showWidgetCenter extends StatelessWidget {
  const showWidgetCenter({
    super.key,
    required this.screenHight,
    required this.screenWidth,
  });

  final double screenHight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: screenHight / 4,
        width: screenWidth / 1.3,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color.fromARGB(150, 165, 165, 165)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
                width: screenWidth / 3, 'assets/lotties/messages.json'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 7),
              child: Text(
                LocaleKeys.youcansend.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
