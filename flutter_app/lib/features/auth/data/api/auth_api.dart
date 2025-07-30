import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/models/user.dart';
import '../../domain/dto/login_request.dart';
import '../../domain/dto/register_request.dart';
import '../dto/auth_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/api/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/api/auth/register')
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @GET('/api/auth/verify')
  Future<User> verifyToken(@Header('Authorization') String token);

  @GET('/api/user/profile')
  Future<User> getProfile(@Header('Authorization') String token);
}