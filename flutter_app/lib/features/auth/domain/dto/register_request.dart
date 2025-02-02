import 'package:flutter_chat_client/features/user/domain/dto/user_role.dart';

class RegisterRequest {
  final String email;
  final String password;
  final String usernick;
  final String? username;
  final UserRole role;
  final bool isActive;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.usernick,
    this.username = 'no name',
    this.role = UserRole.roleUser,
    this.isActive = false,
  });
}
