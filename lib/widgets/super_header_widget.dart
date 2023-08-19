// ignore_for_file: unnecessary_null_comparison

import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../translations/locale_keys.g.dart';

class supervisorHeaderWidget extends StatelessWidget {
  const supervisorHeaderWidget({
    super.key,
    required this.StudentName,
    required this.classGrade,
    required this.grade,
    required this.titleColor,
  });

  final String StudentName;
  final Map<String, dynamic> grade;
  final Map<String, dynamic> classGrade;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Icon(Icons.person),
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
                StudentName,
                style: TextStyle(
                    color: titleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Euclid Circular A'),
              ),
              grade != null
                  ? grade != null
                      ? Text(
                          '${LocaleKeys.grade.tr()} ${grade['name']}/${classGrade['name']}',
                          style: AppTextStyles.profile2,
                        )
                      : Text(
                          '${LocaleKeys.grade.tr()} ${grade['name']}/null',
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
    );
  }
}
