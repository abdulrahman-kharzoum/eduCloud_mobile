import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/widgets/marks_screen_widgets/select_bar_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/head_profile_widget.dart';
import '../widgets/marks_screen_widgets/header_mark_widget.dart';
import './home_screen.dart';

// ignore: camel_case_types
class MarksScreen extends StatefulWidget {
  static const String routeName = '/marks-screen';
  const MarksScreen({super.key});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

// ignore: camel_case_types
class _MarksScreenState extends State<MarksScreen> {
  final Map<String, dynamic> dummyData = {
    'exam': {
      'grand total': 1415,
      'Percentage': '78.6%',
      'Arrangement': 37,
      'subjects': [
        {
          'name': 'math',
          'mark': 500,
          'full': 600,
          'fail': 300,
        },
        {
          'name': 'sciences',
          'mark': 150,
          'full': 200,
          'fail': 100,
        },
        {
          'name': 'physics',
          'mark': 120,
          'full': 200,
          'fail': 100,
        },
        {
          'name': 'english',
          'mark': 345,
          'full': 400,
          'fail': 200,
        },
        {
          'name': 'arabic',
          'mark': 300,
          'full': 400,
          'fail': 200,
        },
      ]
    },
    'quizes': {
      'grand total': 210,
      'Percentage': '52.5%',
      'Arrangement': 25,
      'subjects': [
        {
          'name': 'math1',
          'mark': 40,
          'full': 100,
          'fail': 50,
        },
        {
          'name': 'math2',
          'mark': 10,
          'full': 100,
          'fail': 50,
        },
        {
          'name': 'arabic',
          'mark': 90,
          'full': 100,
          'fail': 50,
        },
        {
          'name': 'chemistry',
          'mark': 70,
          'full': 100,
          'fail': 50,
        },
      ]
    }
  };

  int marksStatus = 0; //0-> exams || 1-> quizes
  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }),
        title: Container(
          margin: context.locale.toString() == 'en'
              ? EdgeInsets.only(left: screenWidth / 100, top: screenHight / 100)
              : EdgeInsets.only(
                  right: screenWidth / 100, top: screenHight / 100),
          child: headProfileWidget(
              screenHight: screenHight,
              screenWidth: screenWidth,
              nameColor: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          //this container is the head of the mark screen
          //it has user name , image , percentage , ect..
          headerMarkWidget(marksStatus: marksStatus, dummyData: dummyData),
          selectBarWidget(
            dummyData: dummyData,
          ),
        ],
      ),
    );
  }
}
