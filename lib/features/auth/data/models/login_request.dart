class LoginRequest {
  final String email;
  final String password;
  final String fcmToken;

  LoginRequest(
      {required this.email, required this.password, required this.fcmToken});
  Map<String, dynamic> toJson() =>
      {"email": email, "password": password, "fcm_token": fcmToken};
}
