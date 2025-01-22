import 'package:flutter_chat_client/artifacts/repository/user_repository.dart';
import 'package:flutter_chat_client/artifacts/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool isLoading;
  final String? errorMessage;

  LoginState({this.isLoading = false, this.errorMessage});
}

class LoginNotifier extends StateNotifier<LoginState> {
  final UserRepo _userRepo;

  LoginNotifier(this._userRepo) : super(LoginState());

  Future<void> userLogin(String email, String password) async {
    state = LoginState(isLoading: true);
    try {
      await _userRepo.login(email, password);
      state = LoginState();
    } catch (e) {
      state = LoginState(errorMessage: 'Login failed');
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) {
    final userService = ref.read(userServiceProvider);
    return LoginNotifier(userService);
  },
);

final authProvider = StateProvider<bool>((ref) => false);
