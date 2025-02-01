import 'package:flutter_chat_client/features/auth/data/secure_storage.dart';
import 'package:flutter_chat_client/features/auth/domain/dto/auth_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  final storage = FlutterSecureStorage();
  return SecureStorage(storage);
});

final authProvider = Provider<AuthStatus>((ref) {
  final storageManager = ref.read(secureStorageProvider);
  return AuthStatus(storageManager);
});
