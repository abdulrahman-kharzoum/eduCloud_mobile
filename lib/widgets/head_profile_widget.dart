import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routing/app_router.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

// ignore: camel_case_types
class headProfileWidget extends StatelessWidget {
  const headProfileWidget({
    super.key,
    required this.screenHight,
    required this.screenWidth,
    required this.studentName,
    required this.gradeNumber,
    required this.icon,
    required this.nameColor,
    required this.circleColor,
  });

  final double screenHight;
  final double screenWidth;
  final String studentName;
  final Icon icon;
  final String gradeNumber;

  final Color nameColor;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //this container for user image
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AppRouter.profileScreen);
            /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );*/
          },
          child: Container(
            //first layer light blue
            padding: const EdgeInsets.all(3),

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightBlue,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  spreadRadius: 0.11,
                  blurRadius: 3,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              //second layer white
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
              child: Center(
                child: icon,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        //this column for student name&grade
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              studentName,
              style: TextStyle(
                  color: nameColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Euclid Circular A'),
            ),
            Text(
              gradeNumber,
              style: AppTextStyles.profile2,
            ),
          ],
        )
      ],
    );
  }
}
