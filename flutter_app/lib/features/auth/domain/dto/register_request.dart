import 'package:json_annotation/json_annotation.dart';
import '../models/user.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  final String userNick;
  final String? username;
  final UserRole userRole;
  final bool isActive;

  const RegisterRequest({
    required this.email,
    required this.password,
    required this.userNick,
    this.username,
    this.userRole = UserRole.user,
    this.isActive = true,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
