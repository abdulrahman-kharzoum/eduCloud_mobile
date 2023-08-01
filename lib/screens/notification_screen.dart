import 'package:educloud_mobile/common_widgets/BackgroundPaint.dart';
import 'package:educloud_mobile/providers/notification_provider.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/styles/app_colors.dart';
import 'package:educloud_mobile/widgets/fav_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Notification.dart';

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
                      icon:
                          Icon(Icons.favorite, color: AppColors.secondaryColor),
                      text: 'Favorites',
                    ),
                  );
                }
              }
              return Tab(
                icon: Icon(Icons.favorite, color: AppColors.secondaryColor),
                text: 'Favorites',
              );
            },
          ),
          Tab(
            icon: Icon(Icons.search, color: AppColors.secondaryColor),
            text: 'Search',
          ),
          Tab(
            icon: Icon(Icons.info, color: AppColors.secondaryColor),
            text: 'Information',
          ),
          Tab(
            icon: Icon(Icons.notifications, color: AppColors.secondaryColor),
            text: 'Notifications',
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
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
                      FavoritesTab(),
                      Container(
                        child: Text('2'),
                      ),
                      Container(
                        child: Text('3'),
                      ),
                      Container(
                        child: Text('4'),
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
                        onPressed: () =>
                            GoRouter.of(context).push(AppRouter.homeScreen),
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
