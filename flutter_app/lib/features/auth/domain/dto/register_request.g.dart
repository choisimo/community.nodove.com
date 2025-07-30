// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      userNick: json['userNick'] as String,
      username: json['username'] as String?,
      userRole: $enumDecodeNullable(_$UserRoleEnumMap, json['userRole']) ??
          UserRole.user,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'userNick': instance.userNick,
      'username': instance.username,
      'userRole': _$UserRoleEnumMap[instance.userRole]!,
      'isActive': instance.isActive,
    };

const _$UserRoleEnumMap = {
  UserRole.user: 'USER',
  UserRole.admin: 'ADMIN',
  UserRole.moderator: 'MODERATOR',
};
