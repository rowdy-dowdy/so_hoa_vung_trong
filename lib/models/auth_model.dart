import 'package:so_hoa_vung_trong/models/user_model.dart';

enum AuthState {
  initial,
  login,
  notLogin
}

enum AuthType {
  teacher,
  student
}

class AuthModel {
  final AuthState authState;
  final UserModel? user;
  final String? token;
  
  AuthModel({
    required this.user,
    required this.authState,
    required this.token,
  });

  const AuthModel.unknown()
    : authState = AuthState.initial,
      user = null,
      token = null;

  AuthModel changeState (AuthState authState) {
    return AuthModel(user: user, authState: authState, token: token);
  }
}