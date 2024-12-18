class VerifyCodeRequest {
  final String email;
  final String code;
  final String fcmToken;

  VerifyCodeRequest(
      {required this.email, required this.code, required this.fcmToken});
  Map<String, dynamic> toJson() =>
      {"email": email, "code": code, "fcm_token": fcmToken};
}
