import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/providers/notification_provider.dart';
import 'package:educloud_mobile/routing/app_router.dart';
import 'package:educloud_mobile/screens/notification_body.dart';

import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles/app_colors.dart';

class NotesTab extends StatefulWidget {
  NotesTab({
    super.key,
  });

  @override
  State<NotesTab> createState() => _NotesTabState();
}

class _NotesTabState extends State<NotesTab> {
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
                    ? GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationBody(
                                id: value.notifications[index].id),
                          ),
                        ),
                        child: Badge(
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.notifications),
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
                      )
                    : Card(
                        child: ListTile(
                          leading: Icon(Icons.notifications),
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
