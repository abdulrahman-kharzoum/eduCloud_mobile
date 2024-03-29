import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:educloud_mobile/constants/configration.dart';
import 'package:educloud_mobile/constants/sharedPreferences.dart';
import 'package:educloud_mobile/models/student.dart';
import 'package:educloud_mobile/models/user.dart';
import 'package:educloud_mobile/sever/apis.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  User user = User();
  final dio = Dio(
    BaseOptions(
      // baseUrl: 'http://localhost:8000',
      // connectTimeout: Duration(seconds: 5),
      // receiveTimeout: Duration(seconds: 10),
      // 5s

      headers: {
        // 'Authorization': 'Bearer 2|PPYaZ5XnbAe6KYeXzRiD3YM5l6cVHGfuLa0fjMdf',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
    ),
  );

  Future<bool> loginApi(String username, String password) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    List<String> roles = [];
    try {
      var body = {
        "user_name": username,
        "password": password,
      };
      var bodyJson = jsonEncode(body);
      Uri uri = Uri.parse(
          '$baseUrl/auth/login');

      Response response = await dio.postUri(uri, data: body);
      print("response:");
      print(response.statusCode);
      print(response.statusMessage);

      print(response);
      if (response != null && response.statusCode == 200) {
        if (response.data["message"] != null &&
            response.data["data"]["token"] != null) {
          _preferences.setString(token, response.data["data"]["token"]);
        }
        var list = response.data["data"]["roles"] as List<dynamic>;

        if (response.data != null) {
          if (response.data["message"] == "logged in successfully") {
            for (var i = 0; i < list.length; i++) {
              roles.add(list[i] as String);
            }
            _preferences.setStringList(role, roles);
            return true;
          }
          return false;
        }
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
    return false;
  }
}
