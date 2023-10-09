
import 'package:dio/dio.dart';
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://run.mocky.io/v3/',
        receiveDataWhenStatusError: true,
        followRedirects: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token
  }) async
  {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData({
    required String url,
    required  data,
    String? token
  }) async
  {
    return await dio.post(
      url,
      data: data,
    );
  }
}