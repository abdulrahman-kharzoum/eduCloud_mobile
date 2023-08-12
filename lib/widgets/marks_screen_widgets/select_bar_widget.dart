import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'header_mark_widget.dart';
import 'mark_bar_widget.dart';

// ignore: camel_case_types
class selectBarWidget extends StatefulWidget {
  const selectBarWidget(
      {super.key,
      required this.data,
      required this.marksType,
      required this.subjectsName});
  final List<dynamic> data;
  final List<String> marksType;
  final List<String> subjectsName;

  @override
  // ignore: library_private_types_in_public_api
  _selectBarWidgetState createState() => _selectBarWidgetState();
}

// ignore: camel_case_types
class _selectBarWidgetState extends State<selectBarWidget> {
  String selectedSubject = '';
  String selectedMark = '';
  double total = 0;
  double fullTotal = 0;
  double percentage = 0;
  List<dynamic> marks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedMark = widget.marksType.first;
    selectedSubject = widget.subjectsName.first;
  }

  Future<void> getMarks() async {
    setState(() {
      total = 0;
      fullTotal = 0;
      if (selectedMark != LocaleKeys.all.tr()) {
        selectedSubject == LocaleKeys.all.tr()
            ? marks = widget.data
                .where((element) => element['type_name'] == selectedMark)
                .toList()
            : marks = widget.data
                .where((element) =>
                    element['type_name'] == selectedMark &&
                    element['subject_name'] == selectedSubject)
                .toList();
      } else {
        selectedSubject == LocaleKeys.all.tr()
            ? marks = widget.data
            : marks = widget.data
                .where((element) => element['subject_name'] == selectedSubject)
                .toList();
      }
      for (int i = 0; i < marks.length; i++) {
        fullTotal += marks[i]['max_mark'];
        if (marks[i]['mark'] == null) {
          total += 0;
        } else {
          total += marks[i]['mark'];
        }
      }
      percentage = (total + 0.001) * 100 / fullTotal;
    });
    setState(() {
      print('...........................................asdfasdf');
      print(fullTotal.toString());
      print(total.toString());
      print(percentage.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Apis.marksDataList.isEmpty
        //if the data is empty here we show something to provide this
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 228, 228, 228),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/images/emptyExam.png',
                    ),
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Text(
                    LocaleKeys.sorry.tr(),
                    style: AppTextStyles.profile,
                  )
                ],
              ),
            ),
          )
        : FutureBuilder(
            future: getMarks(),
            builder: (context, snapshot) => Column(
              children: [
                headerMarkWidget(
                  fullMark: fullTotal,
                  total: total,
                  percentage: percentage,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  //this row has tow drop down menu for marks and subjects
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.marks.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedMark,
                        onChanged: (value) {
                          setState(() {
                            selectedMark = value!;
                          });
                        },
                        items: widget.marksType.map((mark) {
                          return DropdownMenuItem<String>(
                            value: mark,
                            child: Text(mark),
                          );
                        }).toList(),
                      ),
                      Text(
                        LocaleKeys.subjects.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        value: selectedSubject,
                        onChanged: (value) {
                          setState(() {
                            selectedSubject = value!;
                            print(selectedSubject);
                          });
                        },
                        items: widget.subjectsName.map((subject) {
                          return DropdownMenuItem<String>(
                            value: subject,
                            child: Text(subject),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                //this sized box to show the marks
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.45,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: marks.length,
                        itemBuilder: (context, index) {
                          return markBarWidget(
                            type: marks[index]['type_name'].toString(),
                            title: marks[index]['test_title'].toString(),
                            barColor: index % 2 == 0
                                ? const Color.fromARGB(255, 248, 248, 248)
                                : const Color.fromARGB(255, 236, 236, 236),
                            subjectName:
                                marks[index]['subject_name'].toString(),
                            studentMark: marks[index]['mark'].toString(),
                            fullMark: marks[index]['max_mark'].toString(),
                            failMark: marks[index]['min_mark'].toString(),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
