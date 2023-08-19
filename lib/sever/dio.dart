import 'package:dio/dio.dart';
import 'package:educloud_mobile/constants/configration.dart';

Dio dio() {
  Dio dio = Dio();

  dio.options.baseUrl = baseUrl;

  dio.options.headers['Accept'] = 'application/json';
  // dio.options.headers['Access-Control-Allow-Origin'] = '*';

  return dio;
}
