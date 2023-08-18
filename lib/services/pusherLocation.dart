import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:educloud_mobile/constants/configration.dart';
import 'package:educloud_mobile/main.dart';
import 'package:educloud_mobile/models/Location.dart';
import 'package:educloud_mobile/providers/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
        onEvent: (event) async {
          try {
            print("----------------------event--------------------");

            if (event != null && event.data != null) {
              var jsonDataForLocation = jsonDecode(event.data);
              print("jsonDataForLocation Decoded : ");
              print(jsonDataForLocation);

              Map<String, dynamic> jsonMap = json.decode(jsonDataForLocation);
              Map<String, dynamic> locationData = jsonMap['data']['Location'];
              double latitude = locationData['latitude'];
              double longitude = locationData['longitude'];
              String message = locationData['message'];
              LatLng busLocation = LatLng(latitude, longitude);
              if (jsonMap['data']['StartingPoint'] != null &&
                  jsonMap['data']['EndingPoint'] != null) {
                Map<String, dynamic> startingPointData =
                    jsonMap['data']['StartingPoint'];
                Map<String, dynamic> endingPointData =
                    jsonMap['data']['EndingPoint'];

                if (startingPointData.isNotEmpty &&
                    endingPointData.isNotEmpty) {
                  double startingPoint_latitude = startingPointData['latitude'];
                  double startingPoint_longitude =
                      startingPointData['longitude'];

                  double endingPoint_latitude = endingPointData['latitude'];
                  double endingPoint_longitude = endingPointData['longitude'];

                  LatLng startingPoint =
                      LatLng(startingPoint_latitude, startingPoint_longitude);
                  LatLng endingPoint =
                      LatLng(endingPoint_latitude, endingPoint_longitude);
                  (scaffoldMessengerKey.currentContext!)
                      .read<LocationProvider>()
                      .trackBus(busLocation, startingPoint, endingPoint);
                  print('Latitude: $latitude');
                  print('Longitude: $longitude');
                  print('Message: $message');
                }
              }
              if (jsonMap['data']['StartingPoint'] == null &&
                  jsonMap['data']['EndingPoint'] == null) {
                (scaffoldMessengerKey.currentContext!)
                    .read<LocationProvider>()
                    .trackBus(busLocation, null, null);
              }
              //var eve = location.fromJson(jsonDecode(jsonDataForLocation));
              /*print("type ::::");
              print(jsonDataForLocation[0]);
              print(jsonDataForLocation["data"]["Location"]);*/
              /* LatLng busLocation = LatLng(eve.data!.location!.latitude!,
                  eve.data!.location!.longitude!);
              if (eve.data!.startingPoint != null &&
                  eve.data!.startingPoint!.latitude != null &&
                  eve.data!.startingPoint!.longitude != null &&
                  eve.data!.endingPoint != null &&
                  eve.data!.endingPoint!.latitude != null &&
                  eve.data!.endingPoint!.longitude != null) {
                LatLng? startingPoint = LatLng(
                    eve.data!.startingPoint!.latitude!,
                    eve.data!.startingPoint!.longitude!);
                LatLng? endingPoint = LatLng(eve.data!.endingPoint!.latitude!,
                    eve.data!.endingPoint!.longitude!);

                LocationProvider()
                    .trackBus(busLocation, startingPoint, endingPoint);
              } else {
                LocationProvider().trackBus(busLocation, null, null);
              }
*/
              print("after ----------------");
            }
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
