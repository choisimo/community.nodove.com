import 'dart:convert';
import 'dart:developer';
import 'package:flutter_chat_client/artifacts/repository/token_repository.dart';
import 'package:flutter_chat_client/artifacts/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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
      log('Login Successful');

      final accessToken = response.headers['authorization'];
      if (accessToken != null && accessToken.startsWith('Bearer ')) {
        log('Access Token: $accessToken');
        await TokenStorage.saveAccessToken(accessToken.substring(7));
      }

      final refreshToken = response.headers['refresh-token'];
      if (refreshToken != null && refreshToken.startsWith('Refresh ')) {
        log('Refresh Token: $refreshToken');
        await TokenStorage.saveRefreshToken(refreshToken.substring(8), ref);
      }
      return true;
    } else {
      log('Login Failed');
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
}

final userServiceProvider = Provider<UserRepo>((ref) {
  return UserService(baseUrl: 'https://auth.nodove.com');
});
