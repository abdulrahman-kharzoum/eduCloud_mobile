import 'package:educloud_mobile/models/Notification.dart';
import 'package:educloud_mobile/providers/notification_provider.dart';

import 'package:educloud_mobile/services/pusher_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/app_colors.dart';

class FavoritesTab extends StatefulWidget {
  List<MyNotification> Notifications;
  FavoritesTab({
    required this.Notifications,
    super.key,
  });

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  PusherChannel p = PusherChannel();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          widget.Notifications.length, // Replace with your actual item count
      itemBuilder: (BuildContext context, int index) {
        return Consumer<NotificationProvider>(
          builder: (context, value, child) => Card(
            elevation: 0,
            shadowColor: Colors.white,
            color: AppColors.InfoCardColor,
            child: ListTile(
              leading: Icon(Icons.location_on_rounded),
              title: Text(value.notifications[index].title),
            ),
          ),
        );
      },
    );
  }
}
