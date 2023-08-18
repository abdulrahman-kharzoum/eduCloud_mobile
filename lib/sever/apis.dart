import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sever/dio.dart';
import 'package:dio/dio.dart' as Dio;

class Apis with ChangeNotifier {
  static Map<String, dynamic> responseMessage = {};
  static List<dynamic> marksDataList = [];
  static Map<String, dynamic> studentData = {};

  Future<void> sendComplaint(
      {required String message, required String date}) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    try {
      Dio.Response response = await dio().post(
        "/general/message/-1",
        data: {
          'message': message,
          'date_time': date,
        },
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer ${_preferences.getString('token')}'
          },
        ),
      );
      if (response.statusCode == 200) {
        print(
            '................................send complaint server ${response.statusCode}');
        print(response.data);
        responseMessage = response.data;
        notifyListeners();
        print('................................');
      }
    } on DioException catch (e) {
      print(e);
      print(dio().options.baseUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> marksOfStudent() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    try {
      Dio.Response response = await dio().get(
        "/general/getMarksOfStudent/-1",
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer ${_preferences.getString('token')}'
          },
        ),
      );
      print(
          '................................get student mark server ${response.statusCode}');
      print(response.data);
      responseMessage = response.data;
      marksDataList = response.data['data'];

      notifyListeners();
      print('................................');
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> studentInfo() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    try {
      Dio.Response response = await dio().get(
        "/general/viewStudent/-1",
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer ${_preferences.getString('token')}'
          },
        ),
      );
      print(
          '................................get student data server ${response.statusCode}');
      print(response.data);
      responseMessage = response.data;
      print(responseMessage);
      studentData = response.data;
      notifyListeners();
      print('................................');
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
