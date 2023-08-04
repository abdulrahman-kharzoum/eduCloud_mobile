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
    required this.nameColor,
  });

  final double screenHight;
  final double screenWidth;
  final Color nameColor;

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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.person,
                  size: 25,
                ),
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
              'Alaa shibany',
              style: TextStyle(
                  color: nameColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Euclid Circular A'),
            ),
            Text(
              'Grade 9',
              style: AppTextStyles.profile2,
            ),
          ],
        )
      ],
    );
  }
}
