import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/models/model.dart';
import 'package:educloud_mobile/screens/supervisor/chat_super_screen.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../common_widgets/BackgroundPaint.dart';
import '../widgets/app_drawer.dart';
import '../widgets/super_header_widget.dart';

class contactScreen extends StatefulWidget {
  const contactScreen({
    super.key,
  });

  @override
  State<contactScreen> createState() => _contactScreenState();
}

class _contactScreenState extends State<contactScreen> {
  bool _isLoading = false;
  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Apis>(context, listen: false).supervisorContacts();
      print('hello');
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Stack(
              children: [
                CustomPaint(
                  //this for the background
                  size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                    // (screenWidth * 2.1434668500180276)
                    //     .toDouble()
                  ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: Background(),
                ),
                Center(
                  child: Lottie.asset(
                      width: MediaQuery.of(context).size.width / 3,
                      'assets/lotties/loading.json'),
                )
              ],
            ),
          )
        : Scaffold(
            extendBodyBehindAppBar: true,
            drawer: const appDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Container(
                margin: context.locale.toString() == 'en'
                    ? EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 100,
                        bottom: MediaQuery.of(context).size.height / 100)
                    : EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 100,
                        bottom: MediaQuery.of(context).size.height / 100),
                child: supervisorHeaderWidget(
                  titleColor: AppColors.mainColor,
                  StudentName: 'Supervisor',
                  classGrade: {'name': 'chat supervisor'},
                  grade: {'name': ''},
                ),
              ),
            ),
            body: Stack(
              children: [
                CustomPaint(
                  //this for the background
                  size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                  painter: Background(),
                ),
                ListView.builder(
                  // padding: EdgeInsets.zero,
                  itemCount:
                      Apis.supervisorContactsData['conversations'].length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          // You can use an image here as the user's icon
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.mainColor, // Border color
                                width: 1.0, // Border width
                              ),
                            ),
                            child: const Center(child: Icon(Icons.person)),
                          ),
                        ),
                        title: Text(
                          Apis.supervisorContactsData['conversations'][index]
                              ['student']['full_name'],
                          style: TextStyle(
                            color: AppColors.titleTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Euclid Circular A',
                          ),
                        ),
                        subtitle: Apis.supervisorContactsData['conversations']
                                [index]['complaint']
                            ? Text(
                                Apis.supervisorContactsData['conversations']
                                    [index]['body'],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Euclid Circular A',
                                ),
                              )
                            : const Text(
                                'Hi, i am using eduCloud',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Euclid Circular A',
                                ),
                              ),
                        trailing: Text(
                          Apis.supervisorContactsData['conversations'][index]
                                  ['date_time']
                              .toString()
                              .substring(0, 10),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Euclid Circular A',
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            Model.StudentId =
                                Apis.supervisorContactsData['conversations']
                                    [index]['student_id'];
                          });
                          Navigator.of(context).pushNamed(
                            superChatScreen.routeName,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
