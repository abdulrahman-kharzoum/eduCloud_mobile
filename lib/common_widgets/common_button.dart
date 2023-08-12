import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class Common_Button extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  Common_Button({required this.text, this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: GestureDetector(
        onTap: () {
          // Handle button press here
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 70),
          // padding: EdgeInsets.only(right: 16, left: 16),
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.gradientColorsButtom,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.textTitleStyle
                  .copyWith(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
