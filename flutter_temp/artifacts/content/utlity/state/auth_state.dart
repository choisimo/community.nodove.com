import 'dart:developer';

import 'package:flutter_chat_client/artifacts/repository/token_repository.dart';
import 'package:flutter_chat_client/artifacts/repository/user_repository.dart';
import 'package:flutter_chat_client/artifacts/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthState {
  final bool isLoading; // if loading is true then show loading screen
  final bool? token; // if token exists then is LoggedIn
  final String? errorMessage; // if error occurs then show error message

  AuthState({this.isLoading = false, this.token = false, this.errorMessage});

  factory AuthState.initial() {
    return AuthState(isLoading: false, token: false, errorMessage: null);
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final UserRepo _userRepo;

  AuthNotifier(this._userRepo) : super(AuthState());

  // initialize token
  Future<void> initialize() async {
    final token = await TokenStorage.getToken();
    state = AuthState(isLoading: false, token: token != null);
  }

  // login : request Login to Server and Save Token
  Future<void> login(String email, String password, WidgetRef ref) async {
    state = AuthState(isLoading: true);
    try {
      // check if login is successful
      final loginStatus = await _userRepo.login(email, password, ref);
      if (loginStatus) {
        state = AuthState(isLoading: false, token: true);
        log('Login Successful');
      } else {
        state = AuthState(
            isLoading: false, token: false, errorMessage: 'Login failed');
      }
    } catch (e) {
      // if login failed
      log(e.toString());
      state = AuthState(isLoading: false, errorMessage: 'Login failed');
    }
  }

  // logout : remove token and setState to null
  Future<void> logout() async {
    await TokenStorage.removeToken();
    // if token is null then set state to false
    state = AuthState(token: null);
  }
}

// StateNotifierProvider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    log('AuthNotifierProvider');
    final userRepo = ref.read(userServiceProvider);
    final notifier = AuthNotifier(userRepo);
    notifier.initialize();
    return notifier;
  },
);

final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());
