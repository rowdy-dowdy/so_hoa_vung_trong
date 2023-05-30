// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:so_hoa_vung_trong/config/app.dart';
import 'package:so_hoa_vung_trong/models/user_model.dart';
import 'package:so_hoa_vung_trong/services/dio.dart';
import 'package:so_hoa_vung_trong/services/shared_prefs.dart';

class UserData {
  final UserModel user;
  final String token;

  UserData({
    required this.user,
    required this.token,
  });
}

class AuthRepository {
  final Ref ref;
  final Dio dio;

  AuthRepository({
    required this.ref,
    required this.dio,
  });

  Future<UserModel?> userDataById(String id) async {
    try {
      var url = Uri.https(BASE_URL, '/api/collections/users/records/:$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.body);
        return user;
      }  
      else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserData?> getCurrentUserData() async {
    // await Future.delayed(const Duration(seconds: 2));
    try {
      final prefs = await ref.read(sharedPrefsProvider.future);
      String? token = await prefs.getString('token');
      String? type = await prefs.getString('type');

      if (token == null || type == null) return null;

      var url = Uri.https(BASE_URL, '/api/resfeshToken');
      var response = await http.post(url, headers: {
        'authorization': "Bearer $token",
      }, body: {
        'type': type
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var user = UserModel.fromMap(data['user']);

        return UserData(user: user, token: data['token']);
      } 
      else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Future<UserModel?> fetchDatauser() async {
  //   try {
  //     // var url = Uri.https(BASE_URL, '/api/Authentication/Authenticate');
  //     // var response = await http.post(url, body: {
  //     //   "username": identity,
  //     //   "password": password
  //     // });

  //     Response response = await dio.post('/api/odata/ApplicationUser');

  //     UserModel user = UserModel.fromMap(response.data['user']);

  //     return user;

  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  Future<UserData?> signInWithPassword(String identity, String password, bool rememberMe) async {
    try {
      Response response = await dio.post('/api/Authentication/Authenticate', data: {
        "userName": identity,
        "password": password
      });

      dio.options.headers['Authorization'] = "Bearer ${response.data['token']}";

      final prefs = await ref.read(sharedPrefsProvider.future);

      if (rememberMe) {
        await prefs.setString('token', response.data['token']);
        await prefs.setString('id', response.data['token']);
      }
      await prefs.setString('landing', 'true');

      UserModel user = UserModel.fromMap(response.data['user']);

      return UserData(user: user, token: response.data['token']);

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logout() async {
    try {
      var url = Uri.https(BASE_URL, '/api/logout');
      await http.post(url);

      final prefs = await ref.read(sharedPrefsProvider.future);
      await prefs.setString('token', "");
      await prefs.setString('type', "");

    } catch (e) {}
  }
}

final authRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return AuthRepository(ref: ref, dio: dio);
});