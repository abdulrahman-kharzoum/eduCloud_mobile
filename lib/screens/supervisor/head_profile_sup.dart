import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class headSupWidget extends StatelessWidget {
  const headSupWidget({
    super.key,
    required this.screenHight,
    required this.screenWidth,
    required this.icon,
    required this.nameColor,
    required this.circleColor,
    required this.userName,
    required this.userRole,
  });

  final double screenHight;
  final double screenWidth;
  final Icon icon;
  final String userName;
  final String userRole;

  final Color nameColor;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          //this container for user image
          InkWell(
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
              child: InkWell(
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
          ),
          const SizedBox(
            width: 20,
          ),
          //this column for student name&grade
          InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed(AppRouter.profileScreen);
              // print(studentData!.fullName);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userName,
                  // Apis.studentData['data']['full_name'],
                  style: TextStyle(
                      color: nameColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Euclid Circular A'),
                ),
                Text(
                  userRole,
                  style: AppTextStyles.profile2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
