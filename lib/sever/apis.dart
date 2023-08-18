import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sever/dio.dart';
import 'package:dio/dio.dart' as Dio;

class Apis with ChangeNotifier {
  static Map<String, dynamic> responseMessage = {};
  static List<dynamic> marksDataList = [];
  static Map<String, dynamic> studentData = {};
  static Map<String, dynamic> studentExpensesInfo = {};
  static Map<String, dynamic> studentExpensesSchoolInfo = {};
  static Map<String, dynamic> studentExpensesBusInfo = {};

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

  Future<void> studentExpenses() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    try {
      Dio.Response response = await dio().get(
        "/student/getStudentsFinanceInformation/-1",
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer ${_preferences.getString('token')}'
          },
        ),
      );
      print(
          '................................get student expenses data server ${response.statusCode}');
      print(response.data);
      studentExpensesInfo = response.data;
      notifyListeners();
      print('................................');
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> studentExpensesSchool() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    try {
      Dio.Response response = await dio().get(
        "/student/getPaymentsOf/-1?schoolPayments?=1",
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer ${_preferences.getString('token')}'
          },
        ),
      );
      print(
          '................................get student expenses school data server ${response.statusCode}');
      print(response.data);
      studentExpensesSchoolInfo = response.data;
      notifyListeners();
      print('................................');
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> studentExpensesBuss() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    try {
      Dio.Response response = await dio().get(
        "/student/getPaymentsOf/-1?schoolPayments?=0",
        options: Dio.Options(
          headers: {
            'Authorization': 'Bearer ${_preferences.getString('token')}'
          },
        ),
      );
      print(
          '................................get student expenses buss data server ${response.statusCode}');
      print(response.data);
      studentExpensesBusInfo = response.data;
      notifyListeners();
      print('................................');
    } on DioException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
