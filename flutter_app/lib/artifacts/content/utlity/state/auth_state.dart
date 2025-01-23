import 'package:flutter_chat_client/artifacts/repository/token_repository.dart';
import 'package:flutter_chat_client/artifacts/repository/user_repository.dart';
import 'package:flutter_chat_client/artifacts/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthState {
  final bool isLoading;
  final bool? token;
  final String? errorMessage;

  AuthState({this.isLoading = false, this.token = false, this.errorMessage});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final UserRepo _userRepo;

  AuthNotifier(this._userRepo) : super(AuthState());

  // initialize token
  Future<void> initialize() async {
    final token = await TokenStorage.getToken();
    state = AuthState(token: token != null ? true : false);
  }

  // login : request Login to Server and Save Token
  Future<void> login(String email, String password, WidgetRef ref) async {
    state = AuthState(isLoading: true);
    try {
      // check if login is successful
      final loginStatus = await _userRepo.login(email, password, ref);
      state = AuthState(token: loginStatus);
    } catch (e) {
      // if login failed
      state = AuthState(errorMessage: 'Login failed');
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
    final userRepo = ref.read(userServiceProvider);
    final notifier = AuthNotifier(userRepo);
    notifier.initialize();
    return notifier;
  },
);

final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());
