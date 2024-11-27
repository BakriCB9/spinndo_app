class ResetPasswordRequest {
  final String email;
  final String newPassword;
  ResetPasswordRequest(this.newPassword, {required this.email});
  Map<String, dynamic> toJson() =>
      {"email": email, "new_password": newPassword};
}
