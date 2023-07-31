import 'package:educloud_mobile/models/Notification.dart';
import 'package:educloud_mobile/providers/base_provider.dart';

class NotificationProvider extends BaseProvider {
  List<MyNotification> _notifications = [];
  setNotifications(List<MyNotification> notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  void addNotification(MyNotification notification) {
    _notifications.add(notification);
    notifyListeners();
    // Notify listeners here if you are using ChangeNotifier or Provider
  }

  List<MyNotification> get notifications => _notifications;
}
