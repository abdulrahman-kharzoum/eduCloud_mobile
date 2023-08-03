import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class MarkWidget extends StatelessWidget {
  final double screenWidth;
  final String title;
  final String img;
  const MarkWidget(
      {required this.title,
      required this.img,
      required this.screenWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        height: 110,
        width: screenWidth / 1.3,
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
        child: Row(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(img),
                ),
              ),
            ),
            Center(
                child: Container(
                    padding: EdgeInsets.all(40),
                    child: Text(
                      title,
                      style:
                          AppTextStyles.textTitleStyle.copyWith(fontSize: 18),
                    ))),
          ],
        ),
      ),
    );
  }
}
