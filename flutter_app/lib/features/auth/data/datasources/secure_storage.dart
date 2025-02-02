import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

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
