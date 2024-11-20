abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;

  LoginError(this.message);
}

class RegisterSuccess extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterError extends AuthState {
  final String message;

  RegisterError(this.message);
}

class RegisterServiceSuccess extends AuthState {}

class RegisterServiceLoading extends AuthState {}

class RegisterServiceError extends AuthState {
  final String message;

  RegisterServiceError(this.message);
}

class VerifyCodeSuccess extends AuthState {}

class VerifyCodeLoading extends AuthState {}

class VerifyCodeError extends AuthState {
  final String message;

  VerifyCodeError(this.message);
}
class ResendCodeSuccess extends AuthState {}

class ResendCodeLoading extends AuthState {}

class ResendCodeError extends AuthState {
  final String message;

  ResendCodeError(this.message);
}
class ResetPasswordSuccess extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordError extends AuthState {
  final String message;

  ResetPasswordError(this.message);
}

class ChooseAccountState extends AuthState {}

class CardState extends AuthState {}
class CanResendState extends AuthState{


}
