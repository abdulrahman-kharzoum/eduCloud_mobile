import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/settings-screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

// ignore: camel_case_types
class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Column(
        children: [
          // Add other settings widgets here
        ],
      ),
    );
  }
}
