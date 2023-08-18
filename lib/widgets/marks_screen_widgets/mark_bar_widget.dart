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
    required this.title,
    required this.type,
  });
  final Color barColor;
  final String subjectName;
  final String title;
  final String type;
  final String studentMark;
  final String fullMark;
  final String failMark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 15),
      height: MediaQuery.of(context).size.height / 12,
      width: double.infinity,
      color: barColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subjectName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$title ($type)',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 70,
                        color: Colors.black54),
                  ),
                ],
              )),
          Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                  color: int.parse(studentMark) < int.parse(failMark)
                      ? Colors.red
                      : Colors.black),
            ),
            child: Center(
              child: Text(
                studentMark,
                style: TextStyle(
                  color: int.parse(studentMark) < int.parse(failMark)
                      ? Colors.red
                      : const Color.fromRGBO(55, 53, 89, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Euclid Circular A',
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
          ),
        ],
      ),
    );
  }
}
// int.parse(studentMark) < int.parse(failMark)