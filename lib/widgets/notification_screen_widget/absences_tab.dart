import 'package:easy_localization/easy_localization.dart';
import 'package:educloud_mobile/providers/notification_provider.dart';

import 'package:educloud_mobile/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles/app_colors.dart';

class AbsencesTab extends StatefulWidget {
  AbsencesTab({
    super.key,
  });

  @override
  State<AbsencesTab> createState() => _AbsencesTabState();
}

class _AbsencesTabState extends State<AbsencesTab> {
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
