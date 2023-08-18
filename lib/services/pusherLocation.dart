import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:educloud_mobile/constants/configration.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherLocationService {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  Future<void> sendLocation(dynamic _data, String eventName) async {
    try {
      if (pusher.connectionState == "CONNECTED") {
        print("--------------start Sendong---------------");

        await pusher
            .trigger(
              PusherEvent(
                  channelName: channelName, eventName: eventName, data: _data),
            )
            .onError((error, stackTrace) => print(error));
        print("---------------------------------end");
      }
    } catch (e) {
      print(e);
    }
  }

  getSignature(String value) {
    var key = utf8.encode(secret);
    var bytes = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC signature in string is: $digest");
    return digest;
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
      "auth": "${apikey}:${getSignature("$socketId:$channelName")}",
    };
  }

  void onDecryptionFailure(String event, String reason) {
    print("onDecryptionFailure: $event reason: $reason");
  }

  void onMemberAdded(String channelName, PusherMember member) {
    print("onMemberAdded: $channelName user: $member");
  }

  void onMemberRemoved(String channelName, PusherMember member) {
    print("onMemberRemoved: $channelName user: $member");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    print(
        "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    print("Me ======: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    try {
      await pusher.init(
        apiKey: apikey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: (event) {
          try {
            print("----------------------event--------------------");
            var eve = jsonDecode(event.data);
            print(jsonDecode(event.data));
            print("Decoded ");
            print(eve);
            print("after ----------------");
          } catch (e) {
            print("error parsing json $e");
          }
        },
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onMemberAdded: onMemberAdded,
        onMemberRemoved: onMemberRemoved,
        onSubscriptionCount: onSubscriptionCount,
        authEndpoint: "$baseUrl/broadcasting/auth",
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(
        channelName: channelName,
      );
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void dispose() {
    pusher.disconnect();
    pusher.unsubscribe(channelName: channelName);
  }
}
