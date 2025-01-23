import 'package:flutter_chat_client/artifacts/dto/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class UserRepo {
  // Login with email and password
  Future<bool> login(String email, String password, WidgetRef ref);

  // Refresh access token
  Future<bool> refreshAccessToken(WidgetRef ref);

  // Get access token from SharedPreferences
  Future<String?> getAccessToken();

  // Logout
  Future<void> logout();

  // Get user info
  Future<User> getUserInfo();
}
