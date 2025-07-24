import 'package:flutter_chat_client/features/auth/data/secure_storage.dart';

class AuthStatus {
  final bool isLoading;
  final bool? token;
  final String? errorMessage;
  final SecureStorage? _storageManager;

  AuthStatus({
    this.isLoading = false, 
    this.token = false, 
    this.errorMessage,
    SecureStorage? storageManager,
  }) : _storageManager = storageManager;

  factory AuthStatus.initial() {
    return AuthStatus(isLoading: false, token: false, errorMessage: null);
  }
  
  AuthStatus copyWith({
    bool? isLoading,
    bool? token,
    String? errorMessage,
  }) {
    return AuthStatus(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
      storageManager: _storageManager,
    );
  }
}
