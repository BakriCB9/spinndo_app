class ResendCodeRequest {
  final String email;

  ResendCodeRequest({required this.email});
  Map<String, dynamic> toJson() => {"email": email};
}
