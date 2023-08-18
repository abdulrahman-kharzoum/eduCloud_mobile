import 'package:dio/dio.dart';
import 'package:educloud_mobile/constants/configration.dart';

Dio dio() {
  Dio dio = new Dio();

  dio.options.baseUrl = baseUrl;
  dio.options.headers['Accept'] = 'application/json';

  return dio;
}
