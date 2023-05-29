// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:so_hoa_vung_trong/models/auth_model.dart';
import 'package:so_hoa_vung_trong/repositories/auth_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:so_hoa_vung_trong/utils/utils.dart';

class AuthNotifier extends StateNotifier<AuthModel> {
  final Ref ref;
  AuthNotifier(this.ref): super(const AuthModel.unknown()) {
    getCurrentUserData();
  }
  
  void getCurrentUserData() async {
    // state = state.changeState(AuthState.loading);
    var data = await ref.read(authRepositoryProvider).getCurrentUserData();

    if (data != null) {
      state = AuthModel(user: data.user, token: data.token, authState: AuthState.login);
      // ref.read(firebaseCloudMessagingServiceProvider).subscribeToTopic();
    }
    else {
      state = AuthModel(user: null, token: null, authState: AuthState.notLogin);
    }
  }

  Future<void> signInWithPassword(BuildContext context, String identity, String password, bool rememberMe) async {
    var data = await ref.read(authRepositoryProvider).signInWithPassword(identity, password, rememberMe);

    if (data != null) {
      state = AuthModel(user: data.user, token: data.token, authState: AuthState.login);
      // ref.read(firebaseCloudMessagingServiceProvider).subscribeToTopic();
      if (context.mounted) {
        context.go("/");
      }
    }
    else {
      if (context.mounted) {
        showSnackBar(context: context, content: "Tài khoản hoặc mật khẩu không chính xác");
      }
    }
  }

  void logout() {
    ref.read(authRepositoryProvider).logout();
    state = AuthModel(user: null, token: null, authState: AuthState.notLogin);
  }
}

final authControllerProvider = StateNotifierProvider<AuthNotifier, AuthModel>((ref) {
  return AuthNotifier(ref);
});