import 'package:flutter_chat_client/artifacts/dto/user.dart';

abstract class UserRepo {
  // Login with email and password
  Future<bool> login(String email, String password);

  // Get access token from SharedPreferences
  Future<String?> getAccessToken();

  // Logout
  Future<void> logout();

  // Get user info
  Future<User> getUserInfo();
}
