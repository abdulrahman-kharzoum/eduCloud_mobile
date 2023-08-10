// ignore_for_file: unused_local_variable

import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/common_widgets/BackgroundPaint.dart';
import 'package:educloud_mobile/providers/notification_provider.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/translations/locale_keys.g.dart';
import 'package:educloud_mobile/widgets/notification_screen_widget/absences_tab.dart';
import 'package:educloud_mobile/widgets/notification_screen_widget/general_tab.dart';
import 'package:educloud_mobile/widgets/notification_screen_widget/homeworks_tab.dart';
import 'package:educloud_mobile/widgets/notification_screen_widget/notes_tab.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/settings-screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

// ignore: camel_case_types
class _NotificationScreenState extends State<NotificationScreen> {
  TabBar get _tabBar => TabBar(
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppColors.mainColor,
        labelColor: AppColors.secondaryColor,
        isScrollable: true,
        // overlayColor: MaterialStateProperty.resolveWith((states) {
        //   // If the button is pressed, return green, otherwise blue
        //   if (states.contains(MaterialState.pressed)) {
        //     return Colors.green;
        //   }
        //   return Colors.blue;
        // }),
        tabs: [
          Consumer<NotificationProvider>(
            builder: (context, value, child) {
              for (var i = 0; i < value.notifications.length; i++) {
                if (value.notifications[i].isRead == false) {
                  return Badge(
                    child: Tab(
                      icon: Icon(Icons.notes, color: AppColors.secondaryColor),
                      text: LocaleKeys.notes.tr(),
                    ),
                  );
                }
              }
              return Tab(
                icon: Icon(Icons.notes, color: AppColors.secondaryColor),
                text: LocaleKeys.notes.tr(),
              );
            },
          ),
          Consumer<NotificationProvider>(
            builder: (context, value, child) {
              for (var i = 0; i < value.notifications.length; i++) {
                if (value.notifications[i].isRead == false) {
                  return Badge(
                    child: Tab(
                      icon: Icon(Icons.person, color: AppColors.secondaryColor),
                      text: LocaleKeys.absences.tr(),
                    ),
                  );
                }
              }
              return Tab(
                icon: Icon(Icons.person, color: AppColors.secondaryColor),
                text: LocaleKeys.absences.tr(),
              );
            },
          ),
          Consumer<NotificationProvider>(
            builder: (context, value, child) {
              for (var i = 0; i < value.notifications.length; i++) {
                if (value.notifications[i].isRead == false) {
                  return Badge(
                    child: Tab(
                      icon: Icon(Icons.library_books,
                          color: AppColors.secondaryColor),
                      text: LocaleKeys.homeworks.tr(),
                    ),
                  );
                }
              }
              return Tab(
                icon:
                    Icon(Icons.library_books, color: AppColors.secondaryColor),
                text: LocaleKeys.homeworks.tr(),
              );
            },
          ),
          Consumer<NotificationProvider>(
            builder: (context, value, child) {
              for (var i = 0; i < value.notifications.length; i++) {
                if (value.notifications[i].isRead == false) {
                  return Badge(
                    child: Tab(
                      icon: Icon(Icons.public, color: AppColors.secondaryColor),
                      text: LocaleKeys.general.tr(),
                    ),
                  );
                }
              }
              return Tab(
                icon: Icon(Icons.public, color: AppColors.secondaryColor),
                text: LocaleKeys.general.tr(),
              );
            },
          ),
          Tab(
            icon: Icon(Icons.sixty_fps_select, color: AppColors.secondaryColor),
            text: LocaleKeys.general.tr(),
          ),
          Tab(
            icon: Icon(Icons.all_inbox, color: AppColors.secondaryColor),
            text: LocaleKeys.general.tr(),
          ),
          Tab(
            icon: Icon(Icons.not_accessible, color: AppColors.secondaryColor),
            text: LocaleKeys.general.tr(),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,

            toolbarHeight: 5,
            // centerTitle: true,
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: AppColors.mainColor, //<-- SEE HERE
                child: _tabBar,
              ),
            ),
            backgroundColor: AppColors.mainColor,
          ),
          body: CustomPaint(
            size: Size(
                screenWidth,
                (screenWidth * 2.1434668500180276)
                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
            painter: Background(),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      NotesTab(),
                      AbsencesTab(),
                      HomeworksTab(),
                      GeneralTab(),
                      Container(
                        child: Center(
                          child: Text("data1"),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text("data2"),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text("data3"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: screenWidth,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.grey.shade500.withOpacity(0.8),
                      Colors.white70.withOpacity(0.5)
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 70,
                      width: screenWidth,
                      child: FloatingActionButton(
                        shape: CircleBorder(eccentricity: 0),
                        backgroundColor: AppColors.mainColor,
                        child: Icon(
                          Icons.home,
                          size: 35,
                          color: AppColors.secondaryColor,
                        ),
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(AppRouter.homeScreen,
                                (Route<dynamic> route) => false),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
