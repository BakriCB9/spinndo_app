class RegisterRequest {
  final String first_name;
  final String last_name;
  final String email;
  final String password;

  RegisterRequest(
      {required this.first_name,
      required this.last_name,
      required this.email,
      required this.password});
  Map<String, dynamic> toJson() => {
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "password": password,
      };
}
