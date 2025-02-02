import 'package:flutter_chat_client/features/user/domain/dto/login_request.dart';
import 'package:flutter_chat_client/features/user/domain/dto/register_request.dart';

abstract class AuthRepository {
  Future<bool> login(LoginRequest loginRequest);
  Future<bool> logout();
  Future<bool> join(RegisterRequest registerRequest);
}
