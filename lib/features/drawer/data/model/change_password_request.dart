class ChangePasswordRequest {
  String currentPassword;
  String newPassword;
  String newConfrimPassword;
  ChangePasswordRequest(
      {required this.currentPassword,
      required this.newConfrimPassword,
      required this.newPassword});

  Map<String, dynamic> toJson() => {
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newConfrimPassword
      };
}
