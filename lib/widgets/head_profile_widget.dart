import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
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
    required this.icon,
    required this.nameColor,
    required this.circleColor,
  });

  final double screenHight;
  final double screenWidth;
  final Icon icon;

  final Color nameColor;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AppRouter.profileScreen),
      child: Row(
        children: [
          //this container for user image
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRouter.profileScreen),
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
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRouter.profileScreen),
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
                  Apis.studentData['data']['full_name'],
                  style: TextStyle(
                      color: nameColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Euclid Circular A'),
                ),
                Apis.studentData['data']['grade'] != null
                    ? Apis.studentData['data']['g_class'] != null
                        ? Text(
                            '${LocaleKeys.grade.tr()} ${Apis.studentData['data']['grade']['name']}/${Apis.studentData['data']['g_class']['name']}',
                            style: AppTextStyles.profile2,
                          )
                        : Text(
                            '${LocaleKeys.grade.tr()} ${Apis.studentData['data']['grade']['name']}/null',
                            style: AppTextStyles.profile2,
                          )
                    : Text(
                        'null/null',
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
