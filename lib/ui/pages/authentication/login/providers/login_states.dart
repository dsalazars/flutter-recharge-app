
class LoginState {
  final bool isLoading;
  final String? token;
  final String? errorMessage;

  LoginState({this.isLoading = false, this.token, this.errorMessage});

  LoginState copyWith({bool? isLoading, String? token, String? errorMessage}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}