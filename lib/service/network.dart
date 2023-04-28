import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Singleton Pattern 으로 생성.
/// Header, baseURL, API_KEY 구성을 일관되게 관리.
class Network {
  static late Dio _dio;
  static final Network _network = Network._internal();

  static Dio get dio => _dio;

  factory Network() {
    return _network;
  }

  Network._internal() {
    _dio = Dio();

    // dio 기본 설정
    _dio.options.baseUrl = dotenv.env['API_URI']!;
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = dotenv.env['API_KEY']!;
    // _dio.options.headers = <String, String>{'Authorization': dotenv.env['API_KEY']!},

    // error 처리
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 요청 전 처리
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 응답 후 처리
        // print('response interceptor : $response');
        return handler.next(response);
      },
      onError: (error, handler) {
        // 에러 처리
        // print('error interceptor : $error');
        return handler.next(error);
      },
    ));
  }
}
