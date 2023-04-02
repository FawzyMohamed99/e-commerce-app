
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class RegisterLoadingState extends AuthState {}
class RegisterSuccessState extends AuthState {}
class FailedToRegisterState extends AuthState {
  String message;
  FailedToRegisterState({required this.message});
}

class LoginLoadingState extends AuthState {}
class LoginSuccessState extends AuthState {}
class FailedToLoginState extends AuthState {
  String message;
  FailedToLoginState({required this.message});
}
