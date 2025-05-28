class ChangeEmailRequest {
  final String oldEmail;
  final String newEmail;
  const ChangeEmailRequest({required this.newEmail, required this.oldEmail});

  Map<String, dynamic> toJson() {
    return {'old_email': oldEmail, 'new_email': newEmail};
  }
}
