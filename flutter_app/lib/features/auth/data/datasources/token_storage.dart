import 'dart:developer';

import 'package:flutter_chat_client/features/auth/data/datasources/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_client/features/auth/data/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  final SecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  TokenStorage(this._secureStorage, this._sharedPreferences);

  Future<void> saveAccessToken(String token) async {
    log('Saving AccessToken');
    await _sharedPreferences.setString('accessToken', token);
  }

  Future<void> saveRefreshToken(String token) async {
    log('Saving RefreshToken');
    if (kIsWeb) {
      log('RefreshToken exists in Http-Only Cookie');
    } else {
      await _secureStorage.saveToken('refreshToken', token);
    }
  }

  Future<String?> getAccessToken() async {
    return _sharedPreferences.getString('accessToken');
  }

  Future<String?> getRefreshToken() async {
    if (kIsWeb) {
      log('RefreshToken exists in Http-Only Cookie');
      return null;
    } else {
      return _secureStorage.getToken('refreshToken');
    }
  }

  Future<void> deleteAccessToken() async {
    await _sharedPreferences.remove('accessToken');
  }

  Future<void> deleteRefreshToken() async {
    if (kIsWeb) {
      log('RefreshToken exists in Http-Only Cookie');
    } else {
      await _secureStorage.removeToken('refreshToken');
    }
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  return TokenStorage(secureStorage, sharedPreferences);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider is not implemented');
});

Future<void> initializeSharePreferences() async {
  final prefs = await SharedPreferences.getInstance();
  sharedPreferencesProvider.overrideWithValue(prefs);
}
