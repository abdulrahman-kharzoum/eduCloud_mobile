import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../sever/dio.dart';
import 'package:dio/dio.dart' as Dio;

class Apis with ChangeNotifier {
  static Map<String, dynamic> responseMessage = {};

  Future<void> sendComplaint(
      {required String message, required String date}) async {
    try {
      Dio.Response response = await dio().post(
        "/V1.0/general/message/-1",
        data: {
          'message': message,
          'date_time': date,
        },
        options: Dio.Options(
          headers: {
            'Authorization':
                'Bearer 16|t2LPVslrZiBEKtX0xUGT893buXwFpVJojRGvZW8G'
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
}
