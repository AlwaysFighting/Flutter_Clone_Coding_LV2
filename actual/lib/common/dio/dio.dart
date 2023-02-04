import 'package:actual/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청을 보내질 때마다 만약에 요청 Header 에 accessToken : true 라고 불릴 때마다 (토큰이 필요할 때마다)
  // 실제 토큰을 가져와서 (storage 에서) 'authorization' :'Bearer $token' 으로
  // 헤더를 변경한다.
  @override
  void onRequest(

      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    // 요청을 보냄
    return super.onRequest(options, handler);
  }

// 2) 응답을 받을 때

// 3) 에러가 났을 때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 토큰 에러가 났을 경우 -> 토큰 재발급 받는 시도를 하고 토큰이 재발급되면 다시 새로운 토큰으로 요청을 한다.
    print('[ERR] [${err.requestOptions.method} ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if(refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if(isStatus401 && isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
            'http://$ip/auth/token',
            options: Options(
                headers: {
                  'authorization': 'Bearer $refreshToken',
                }
            )
        );
        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 에러를 발생시킨 모든 요청을 받아서 토큰만 바꿔서 다시 요청을 재전송하는 것!
        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }
  }
}
