import 'package:flutter_chat_client/features/auth/data/secure_storage.dart';
import 'package:flutter_chat_client/features/auth/domain/dto/auth_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

final authProvider = Provider<AuthStatus>((ref) {
  final storageManager = ref.read(secureStorageProvider);
  return AuthStatus(storageManager: storageManager);
});
