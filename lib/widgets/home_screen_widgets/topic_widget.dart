import 'package:flutter/material.dart';

import '../../styles/app_text_styles.dart';

// ignore: camel_case_types
class topicWidget extends StatelessWidget {
  const topicWidget({
    super.key,
    required this.screenHight,
    required this.screenWidth,
    required this.widgetP,
    required this.topicTitle,
  });

  final double screenHight;
  final double screenWidth;
  final Widget widgetP;
  final String topicTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHight / 5.2,
      width: screenWidth / 2.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 0.01,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: screenHight / 6.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                  spreadRadius: 0.01,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: widgetP,
            ),
          ),
          SizedBox(
            height: screenHight / 100,
          ),
          Center(
            child: Text(
              topicTitle,
              style: AppTextStyles.miniTitle,
            ),
          )
        ],
      ),
    );
  }
}
