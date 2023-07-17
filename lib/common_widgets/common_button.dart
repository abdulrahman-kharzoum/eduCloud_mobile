import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class Common_Button extends StatelessWidget {
  final String text;
  Common_Button(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ElevatedButton(
        onPressed: () {
          debugPrint('ElevatedButton Clicked');
        },
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.gradientColorsButtom),
              borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 300,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              text,
              style: AppTextStyles.textTitleStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
