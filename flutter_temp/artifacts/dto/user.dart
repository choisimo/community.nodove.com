import 'user_role.dart';

class User {
  final String id;
  final String userId;
  final String? username;
  final String email;
  final String userNick;
  final UserRole userRole;
  final bool isActive;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  User({
    required this.id,
    required this.userId,
    this.username,
    required this.userNick,
    required this.email,
    required this.userRole,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String?,
      userNick: json['userNick'] as String,
      email: json['email'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      userRole: UserRoleHelper.fromString(json['userRole'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userNick': userNick,
      'email': email,
      'userRole': UserRoleHelper.toValue(userRole),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}
