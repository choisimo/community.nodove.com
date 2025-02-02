import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  final FlutterSecureStorage _storage;

  SecureStorageManager(this._storage);

  Future<void> saveToken(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> removeToken(String key) async {
    await _storage.delete(key: key);
  }
}

final secureStorageManagerProvider = Provider<SecureStorageManager>((ref) {
  final storage = FlutterSecureStorage();
  return SecureStorageManager(storage);
});
