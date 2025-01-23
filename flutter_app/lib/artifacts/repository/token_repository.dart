import 'package:flutter_chat_client/artifacts/repository/secure_storage_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static Future<void> saveAccessToken(String token) async {
    if (kIsWeb) {
      html.window.localStorage['accessToken'] = token;
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', token);
    }
  }

  static Future<void> saveRefreshToken(String token, WidgetRef ref) async {
    if (kIsWeb) {
      html.window.localStorage['refreshToken'] = token;
    } else {
      final storageManager = ref.read(secureStorageManagerProvider);
      await storageManager.saveToken('refreshToken', token);
    }
  }

  static Future<String?> getToken() async {
    if (kIsWeb) {
      return html.window.localStorage['accessToken'];
    } else {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('accessToken');
    }
  }

  static Future<String?> getRefreshToken(WidgetRef ref) async {
    if (kIsWeb) {
      return html.window.localStorage['refreshToken'];
    } else {
      final storageManager = ref.read(secureStorageManagerProvider);
      return await storageManager.getToken('refreshToken');
    }
  }

  static Future<void> removeToken() async {
    if (kIsWeb) {
      html.window.localStorage.remove('accessToken');
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
    }
  }

  static Future<void> removeRefreshToken(WidgetRef ref) async {
    if (kIsWeb) {
      html.window.localStorage.remove('refreshToken');
    } else {
      final storageManager = ref.read(secureStorageManagerProvider);
      await storageManager.removeToken('refreshToken');
    }
  }
}
