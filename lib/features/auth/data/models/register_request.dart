class RegisterRequest {
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String first_name_ar;
  final String last_name_ar;
  final String phone;

  RegisterRequest(
      {required this.first_name,
      required this.last_name,
      required this.phone,
      required this.email,
      required this.first_name_ar,
      required this.last_name_ar,
      required this.password});
  Map<String, dynamic> toJson() => {
        "first_name": first_name,
         "phone":phone,
        "last_name": last_name,
        "email": email,
        "password": password,
        "first_name_ar": first_name_ar,
        "last_name_ar": last_name_ar
      };
}
