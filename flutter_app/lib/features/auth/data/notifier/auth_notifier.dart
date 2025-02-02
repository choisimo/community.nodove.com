import 'package:flutter_chat_client/features/auth/data/token_storage.dart';
import 'package:flutter_chat_client/features/auth/domain/dto/auth_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthStatus> {
  Future<void> initialize(WidgetRef ref) async {
    final tokenExist = await TokenStorage.getAccessToken(ref);
    if (tokenExist != null) {
      state = AuthStatus(token: true, isLoading: false);
    } else {
      state = AuthStatus(
          token: false, isLoading: false, errorMessage: "cannot find token");
    }
  }
}
