import 'dart:convert';

class MyNotification {
  final int id;
  final String title, body;
  bool isRead = false;
  DateTime dateTime;

  MyNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.dateTime,
  });

  factory MyNotification.fromJson(Map<String, dynamic> jsonData) {
    return MyNotification(
      id: jsonData['id'],
      title: jsonData['title'],
      body: jsonData['body'],
      dateTime: jsonData['dateTime'],
    );
  }

  static Map<String, dynamic> toMap(MyNotification notification) => {
        'id': notification.id,
        'title': notification.title,
        'body': notification.body,
      };

  static String encode(List<MyNotification> notifications) => json.encode(
        notifications
            .map<Map<String, dynamic>>(
                (notification) => MyNotification.toMap(notification))
            .toList(),
      );

  static List<MyNotification> decode(String notifications) =>
      (json.decode(notifications) as List<dynamic>)
          .map<MyNotification>((item) => MyNotification.fromJson(item))
          .toList();
}
