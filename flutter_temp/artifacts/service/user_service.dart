import 'dart:convert';
import 'dart:developer';
import 'package:flutter_chat_client/artifacts/repository/token_repository.dart';
import 'package:flutter_chat_client/artifacts/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: 'https://auth.nodove.com')
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  // Login Request
  @POST("/auth/login")
  Future<HttpResponse<Map<String, dynamic>>> login(
    @Body() Map<String, String> body,
  );

  // Refresh Token Request
  @POST("/auth/refresh")
  Future<HttpResponse<Map<String, dynamic>>> refreshAccessToken(
    @Body() Map<String, String> body,
    @Header("Authorization") String accessToken,
  );

final userServiceProvider = Provider<UserRepo>((ref) {
  return UserService(baseUrl: 'https://auth.nodove.com');
});
