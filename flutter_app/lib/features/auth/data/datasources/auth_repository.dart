import '../api/auth_api.dart';
import '../dto/auth_response.dart';
import '../../domain/dto/login_request.dart';
import '../../domain/dto/register_request.dart';
import '../../domain/models/user.dart';
import 'token_storage.dart';

class AuthRepository {
  final AuthApi _authApi;
  final TokenStorage _tokenStorage;

  AuthRepository(this._authApi, this._tokenStorage);

  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    final response = await _authApi.login(request);
    await _tokenStorage.saveToken(response.token);
    return response;
  }

  Future<AuthResponse> register(String email, String password, String userNick) async {
    final request = RegisterRequest(
      email: email,
      password: password,
      userNick: userNick,
    );
    final response = await _authApi.register(request);
    await _tokenStorage.saveToken(response.token);
    return response;
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
  }

  Future<User?> getCurrentUser() async {
    final token = await _tokenStorage.getToken();
    if (token == null) return null;
    
    try {
      return await _authApi.verifyToken('Bearer $token');
    } catch (e) {
      await _tokenStorage.deleteToken();
      return null;
    }
  }

  Future<String?> getStoredToken() async {
    return await _tokenStorage.getToken();
  }

  Future<User> getProfile() async {
    final token = await _tokenStorage.getToken();
    if (token == null) throw Exception('No token found');
    
    return await _authApi.getProfile('Bearer $token');
  }
}
