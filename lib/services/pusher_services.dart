import 'dart:convert';
import 'package:educloud_mobile/constants/configration.dart';
import 'package:educloud_mobile/models/Notification.dart';
import 'package:educloud_mobile/providers/notification_provider.dart';
import 'package:educloud_mobile/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PusherChannel {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  NotificationProvider notificationProvider = NotificationProvider();
  int id = 0;
  List<MyNotification> notifi = [];
  void onConnectPressed() async {
    void onConnectionStateChange(dynamic currentState, dynamic previousState) {
      debugPrint("Connection: $currentState");
    }

    void onError(String message, int? code, dynamic e) {
      debugPrint("onError: $message code: $code exception: $e");
    }

    triggerNotification(String title, String body) async {
      await NotificationService.showNotification(
        title: title,
        body: body,
      );
    }

    void onEvent(PusherEvent event) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint("onEvent: $event");
      try {
        Map<dynamic, dynamic> ev = json.decode(event.data);
        var title = ev["message"]["title"];
        var body = ev["message"]["body"];

        notificationProvider
            .addNotification(MyNotification(id: id, title: title, body: body));
        notifi.add(MyNotification(id: id, title: title, body: body));

        // Encode and store data in SharedPreferences
        final String encodedData = MyNotification.encode(notifi);
        id++;
        await prefs.setString('notifications_key', encodedData);

        await triggerNotification(title, body);
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    }

    void onSubscriptionSucceeded(String channelName, dynamic data) {
      debugPrint("onSubscriptionSucceeded: $channelName data: $data");
      final me = pusher.getChannel(channelName)?.me;
      debugPrint("Me: $me");
    }

    void onSubscriptionError(String message, dynamic e) {
      debugPrint("onSubscriptionError: $message Exception: $e");
    }

    void onDecryptionFailure(String event, String reason) {
      debugPrint("onDecryptionFailure: $event reason: $reason");
    }

    void onMemberAdded(String channelName, PusherMember member) {
      debugPrint("onMemberAdded: $channelName user: $member");
    }

    void onMemberRemoved(String channelName, PusherMember member) {
      debugPrint("onMemberRemoved: $channelName user: $member");
    }

    try {
      await pusher.init(
        apiKey: apikey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        // authEndpoint: "<Your Authendpoint Url>",
        // onAuthorizer: onAuthorizer
      );
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }
}
