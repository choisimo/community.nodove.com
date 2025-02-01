class AuthStatus {
  final bool isLoading;
  final bool? token;
  final String? errorMessage;

  AuthStatus({this.isLoading = false, this.token = false, this.errorMessage});

  factory AuthStatus.initial() {
    return AuthStatus(isLoading: false, token: false, errorMessage: null);
  }
}
