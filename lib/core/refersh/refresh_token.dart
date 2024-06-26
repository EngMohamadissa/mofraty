import 'package:dio/dio.dart';
import 'package:eghyptproject/core/refersh/token_storage.dart';
import 'package:eghyptproject/core/utils/app_router.dart';

abstract class DioClient {
  String? entity;
  String baseUrl = 'https://backend.almowafraty.com/api/v1/';
  final Dio dio = Dio(
      // BaseOptions(
      //    baseUrl: 'https://backend.almowafraty.com/api/v1',
      //   connectTimeout:Duration(seconds:  15),
      // receiveTimeout: Duration(seconds:  15),
      // ),
      );
  late Response response;
  final TokenStorage tokenStorage = TokenStorage();

  DioClient() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await tokenStorage.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = await tokenStorage.getRefreshToken();
            if (refreshToken != null) {
              try {
                print('**********************************');
                // Assuming you have a function to refresh the token
                final newTokens = await _refreshToken(refreshToken);
                await tokenStorage.saveTokens(
                    newTokens['accessToken']!, newTokens['refreshToken']!);
                print(
                    '4444444444444444444444444${newTokens['accessToken']}+${newTokens['refreshToken']}');
                // Clone the original request and retry with the new access token
                final opts = error.requestOptions;
                opts.headers['Authorization'] =
                    'Bearer ${newTokens['accessToken']}';
                try {
                  final clonedRequest = await dio.fetch(opts);
                  return handler.resolve(clonedRequest);
                } on DioException catch (e) {
                  return handler.reject(e);
                }
              } catch (e) {
                AppRouter.router.go(AppRouter.kloginView);
              }
            } else {
              print('Redirecting to login screen...');
              AppRouter.router.go(AppRouter.kloginView);

              return handler.reject(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }
}

Future<Map<String, dynamic>> _refreshToken(String refreshToken) async {
  Dio dIo = Dio();
  // String? refreshToken = await TokenStorage().getRefreshToken();
  print('66666666666666666666666666666666666666666666666666');
  {
    final refreshToken = await TokenStorage().getRefreshToken();
    print('00000000000000$refreshToken');
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    try {
      final response = await dIo.get(
        'https://backend.almowafraty.com/api/v1/suppliers/refresh-token', // استبدل بالـ URL الصحيح لتجديد التوكين
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );
      print('111111111111${response.data}');
      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];
        print('22222222222222222222$accessToken,+$newRefreshToken');
        if (accessToken != null && newRefreshToken != null) {
          print('333333333333333333333333333${{
            'accessToken': accessToken,
            'refreshToken': newRefreshToken,
          }}');
          return {
            'accessToken': accessToken,
            'refreshToken': newRefreshToken,
          };
        } else {
          throw Exception('Invalid token data received');
        }
      } else {
        throw Exception(
            'Token refresh failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // هنا يمكن التعامل مع الأخطاء المحتملة
      print(e.response);
      throw Exception('Token refresh DioError: ${e.message}');
    }
  }
}
