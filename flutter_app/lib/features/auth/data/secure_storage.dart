// 메모리 기반 간단한 저장소 (데모용)
class SecureStorage {
  static final Map<String, String> _storage = {};
  
  Future<void> write(String key, String? value) async {
    if (value != null) {
      _storage[key] = value;
    }
  }

  Future<String?> read(String key) async {
    return _storage[key];
  }

  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  Future<void> deleteAll() async {
    _storage.clear();
  }
}