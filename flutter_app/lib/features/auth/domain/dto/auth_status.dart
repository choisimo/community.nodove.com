import '../models/user.dart';

sealed class AuthStatus {
  const AuthStatus();
  
  factory AuthStatus.initial() = AuthInitial;
  factory AuthStatus.loading() = AuthLoading;
  factory AuthStatus.authenticated(User user, String token) = AuthAuthenticated;
  factory AuthStatus.unauthenticated() = AuthUnauthenticated;
  factory AuthStatus.error(String message) = AuthError;
}

class AuthInitial extends AuthStatus {
  const AuthInitial();
}

class AuthLoading extends AuthStatus {
  const AuthLoading();
}

class AuthAuthenticated extends AuthStatus {
  final User user;
  final String token;
  
  const AuthAuthenticated(this.user, this.token);
}

class AuthUnauthenticated extends AuthStatus {
  const AuthUnauthenticated();
}

class AuthError extends AuthStatus {
  final String message;
  
  const AuthError(this.message);
}
