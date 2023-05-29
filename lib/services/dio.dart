import 'package:dio/dio.dart';
// import 'package:so_hoa_vung_trong/services/shared_prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/config/app.dart';

final dioProvider = Provider<Dio>((ref) {
  var options = BaseOptions(
    baseUrl: "https://$BASE_URL",
    // connectTimeout: 5000,
    // receiveTimeout: 3000,
  );

  final Dio dio = Dio(options);

  dio.interceptors.add(InterceptorsWrapper(
    // onError: (DioError e, handler) async {
    //   if (e.response?.statusCode == 401 && e.response?.statusMessage == "Unauthorized") {
    //     try {
    //       final prefs = await ref.read(sharedPrefsProvider.future);
    //       final refreshToken = await prefs.getString('refresh_token');

    //       Response response = await dio.post("/api/v1/auth/refresh-token",  data: {
    //         "refresh_token": refreshToken
    //       });

    //       if (response.statusCode == 200) {
    //         await prefs.setString('token', response.data['token']);
    //         await prefs.setString('refresh_token', response.data['refresh_token']);

    //         dio.options.headers['Authorization'] = "Bearer ${response.data['token']}";

    //         e.requestOptions.headers["Authorization"] = "Bearer " + response.data['token'];

    //         final cloneReq = await dio.request(
    //           e.requestOptions.path,
    //           options: Options(
    //             method: e.requestOptions.method,
    //             headers: e.requestOptions.headers
    //           ),
    //           data: e.requestOptions.data,
    //           queryParameters: e.requestOptions.queryParameters
    //         );

    //         return handler.resolve(cloneReq);
    //       }
          
    //     } catch (e) {
    //       print(e);
    //     }
    //   }
    //   return handler.next(e);
    // }
  ));
  return dio;
});