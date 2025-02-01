import 'package:flutter_chat_client/artifacts/repository/user_repository.dart';
import 'package:flutter_chat_client/artifacts/service/user_service.dart';
import 'package:dio/dio.dart';

class UserServiceImpl implements UserRepo {
  final UserService _api;

  UserServiceImpl(Dio dio) : _api = UserService(dio);

  @override
  Future<bool> login(String email, String password, WidgetRef ref) async {
    final response = await _api.login({'email': email, 'password': password});
    try {} catch (e) {
      rethrow;
    }
  }
}
