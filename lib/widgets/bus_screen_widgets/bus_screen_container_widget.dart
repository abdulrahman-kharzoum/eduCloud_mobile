import 'package:flutter/material.dart';

import '../../styles/app_text_styles.dart';

class busScreenContainerWidget extends StatelessWidget {
  const busScreenContainerWidget({
    super.key,
    required this.screenWidth,
    required this.screenHight,
    required this.widget1,
    required this.widget3,
    required this.widget2,
    required this.title1,
    required this.title2,
    required this.title3,
  });

  final double screenWidth;
  final double screenHight;
  final Widget widget1;
  final Widget widget3;
  final Widget widget2;
  final String title1;
  final String title2;
  final String title3;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth / 30),
      width: double.infinity,
      height: screenWidth / 2.8,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 226, 226, 226),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 20, vertical: screenHight / 80),
        child: Column(
          children: [
            SizedBox(
              height: screenHight / 90,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title1,
                  style: AppTextStyles.poppinsTitle3,
                ),
                widget1
              ],
            ),
            SizedBox(
              height: screenHight / 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title2,
                  style: AppTextStyles.poppinsTitle4,
                ),
                widget2
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title3,
                  style: AppTextStyles.poppinsTitle4,
                ),
                widget3
              ],
            ),
          ],
        ),
      ),
    );
  }
}
