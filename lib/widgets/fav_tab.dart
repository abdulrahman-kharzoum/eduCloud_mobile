import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/models/Notification.dart';
import 'package:educloud_mobile/providers/notification_provider.dart';

import 'package:educloud_mobile/services/pusher_services.dart';
import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../styles/app_colors.dart';

class FavoritesTab extends StatefulWidget {
  FavoritesTab({
    super.key,
  });

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.notifications.length,
          itemBuilder: (BuildContext context, int index) {
            return Consumer<NotificationProvider>(
              builder: (context, value, child) => Card(
                elevation: 0,
                shadowColor: Colors.white,
                color: AppColors.InfoCardColor,
                child: (value.notifications[index].isRead == false)
                    ? Badge(
                        child: Card(
                          child: ListTile(
                            leading: Icon(Icons.location_on_rounded),
                            title: Text(value.notifications[index].title),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.MMMMd().format(
                                      value.notifications[index].dateTime),
                                  style: AppTextStyles.miniTitle,
                                ),
                                Text(
                                  DateFormat.jm().format(
                                      value.notifications[index].dateTime),
                                  style: AppTextStyles.miniTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Card(
                        child: ListTile(
                          leading: Icon(Icons.location_on_rounded),
                          title: Text(value.notifications[index].title),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.MMMMd().format(
                                    value.notifications[index].dateTime),
                                style: AppTextStyles.miniTitle,
                              ),
                              Text(
                                DateFormat.jm().format(
                                    value.notifications[index].dateTime),
                                style: AppTextStyles.miniTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
