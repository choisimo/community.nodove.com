import 'dart:convert';
import 'package:flutter_chat_client/artifacts/dto/user.dart';
import 'package:flutter_chat_client/artifacts/repository/token_repository.dart';
import 'package:flutter_chat_client/artifacts/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService implements UserRepo {
  final String baseUrl;

  UserService({required this.baseUrl});

  // Login Request
  @override
  Future<bool> login(String email, String password, WidgetRef ref) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {'email': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final accessToken = responseBody['accessToken'];
      final refreshToken = responseBody['refreshToken'];

      // Set Token
      await TokenStorage.saveAccessToken(accessToken);
      await TokenStorage.saveRefreshToken(refreshToken, ref);

      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> refreshAccessToken(WidgetRef ref) async {
    final accessToken = await TokenStorage.getToken();
    final refreshToken = await TokenStorage.getRefreshToken(ref);
    final url = Uri.parse('$baseUrl/auth/refresh');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode('refreshToken $refreshToken'),
    );
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final newAccessToken = responseBody['accessToken'];
      await TokenStorage.saveAccessToken(newAccessToken);
      return true;
    } else {
      return false;
    }
  }

  // Get Token from SharedPreferences
  @override
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Logout
  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }

  // Get User Info
  @override
  Future<User> getUserInfo() {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }
}

final userServiceProvider = Provider<UserRepo>((ref) {
  return UserService(baseUrl: 'https://auth.nodove.com');
});
