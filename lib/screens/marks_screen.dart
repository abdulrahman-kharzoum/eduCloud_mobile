import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:educloud_mobile/widgets/marks_screen_widgets/select_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/head_profile_widget.dart';

// ignore: camel_case_types
class MarksScreen extends StatefulWidget {
  static const String routeName = '/marks-screen';
  const MarksScreen({super.key});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

// ignore: camel_case_types
class _MarksScreenState extends State<MarksScreen> {
  List<dynamic> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<String> marksType = [];
  List<String> subjectsName = [];

  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Apis>(context, listen: false).marksOfStudent();
      Set<String> type = {LocaleKeys.all.tr()};
      Set<String> subject = {LocaleKeys.all.tr()};
      for (int i = 0; i < Apis.marksDataList.length; i++) {
        type.add(Apis.marksDataList[i]['type_name']);
        subject.add(Apis.marksDataList[i]['subject_name']);
      }
      setState(() {
        marksType = type.toList();
        subjectsName = subject.toList();
        data = Apis.marksDataList;
      });
      print('.........................................hello');
      print(marksType);
      print(subjectsName);

      print('$data  data');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

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
            icon: Icon(
              Icons.arrow_back,
              color: Apis.marksDataList.isEmpty
                  ? AppColors.mainColor
                  : Colors.white,
            ),
            onPressed: () {
              // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              Navigator.pop(context);
            }),
        title: Container(
          margin: context.locale.toString() == 'en'
              ? EdgeInsets.only(left: screenWidth / 100, top: screenHight / 100)
              : EdgeInsets.only(
                  right: screenWidth / 100, top: screenHight / 100),
          child: headProfileWidget(
              icon: const Icon(
                CupertinoIcons.person,
                size: 25,
              ),
              circleColor: AppColors.secondaryColor,
              screenHight: screenHight,
              screenWidth: screenWidth,
              nameColor: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(
              child: Lottie.asset(
                  width: screenWidth / 3, 'assets/lotties/loading.json'),
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                //this container is the head of the mark screen
                //it has user name , image , percentage , ect..
                selectBarWidget(
                  subjectsName: subjectsName,
                  marksType: marksType,
                  data: data,
                ),
              ],
            ),
    );
  }
}
