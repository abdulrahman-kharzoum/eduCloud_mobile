import 'package:flutter/material.dart';

import '../../styles/app_text_styles.dart';

class markBarWidget extends StatelessWidget {
  const markBarWidget({
    super.key,
    required this.barColor,
    required this.subjectName,
    required this.studentMark,
    required this.fullMark,
    required this.failMark,
  });
  final Color barColor;
  final String subjectName;
  final String studentMark;
  final String fullMark;
  final String failMark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: MediaQuery.of(context).size.height / 12,
      width: double.infinity,
      color: barColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subjectName),
          Row(
            children: [
              Container(
                height: 40,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    studentMark,
                    style: AppTextStyles.profile,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_circle_up_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Text(
                        fullMark,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_circle_down_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Text(
                        failMark,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
