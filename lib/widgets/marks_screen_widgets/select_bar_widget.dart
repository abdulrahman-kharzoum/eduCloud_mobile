import 'package:flutter/material.dart';

import 'mark_bar_widget.dart';

// ignore: camel_case_types
class selectBarWidget extends StatefulWidget {
  const selectBarWidget({super.key, required this.dummyData});
  final Map<String, dynamic> dummyData;

  @override
  // ignore: library_private_types_in_public_api
  _selectBarWidgetState createState() => _selectBarWidgetState();
}

// ignore: camel_case_types
class _selectBarWidgetState extends State<selectBarWidget> {
  String selectedTerm = 'All';
  String selectedSubject = 'All';
  String selectedMark = 'Exams';

  final List<String> terms = ['All', 'First', 'Second'];
  final List<String> subjects = ['All', 'Math', 'Science', 'History'];
  final List<String> marks = ['All', 'Quizzes', 'Exams'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mark'),
              DropdownButton<String>(
                value: selectedMark,
                onChanged: (value) {
                  setState(() {
                    selectedMark = value!;
                  });
                },
                items: marks.map((mark) {
                  return DropdownMenuItem<String>(
                    value: mark,
                    child: Text(mark),
                  );
                }).toList(),
              ),
              Text('Subject'),
              DropdownButton<String>(
                value: selectedSubject,
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value!;
                  });
                },
                items: subjects.map((subject) {
                  return DropdownMenuItem<String>(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
              ),
              Text('Term'),
              DropdownButton<String>(
                value: selectedTerm,
                onChanged: (value) {
                  setState(() {
                    selectedTerm = value!;
                  });
                },
                items: terms.map((term) {
                  return DropdownMenuItem<String>(
                    value: term,
                    child: Text(term),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.45,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: widget.dummyData['exam']['subjects'].length,
            itemBuilder: (context, index) {
              return markBarWidget(
                barColor: index % 2 == 0
                    ? const Color.fromARGB(255, 248, 248, 248)
                    : const Color.fromARGB(255, 236, 236, 236),
                subjectName: widget.dummyData['exam']['subjects'][index]['name']
                    .toString(),
                studentMark: widget.dummyData['exam']['subjects'][index]['mark']
                    .toString(),
                fullMark: widget.dummyData['exam']['subjects'][index]['full']
                    .toString(),
                failMark: widget.dummyData['exam']['subjects'][index]['fail']
                    .toString(),
              );
            },
          ),
        )
      ],
    );
  }
}
