import 'package:educloud_mobile/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routing/app_router.dart';

class NotificationBody extends StatelessWidget {
  int id;
  NotificationBody({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Notification Body"),
      ),
      body: Column(
        children: [
          Center(
            child: Consumer<NotificationProvider>(
                builder: (context, value, child) =>
                    Text(value.notifications[id].body)),
          ),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, AppRouter.notificationScreen),
            child: const Text("Go Back"),
          ),
        ],
      ),
    );
  }
}
