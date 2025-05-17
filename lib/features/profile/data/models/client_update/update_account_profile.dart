class UpdateAccountProfile {
  final String firstName;
  final String lastName;
  final String firstNameAr;
  final String lastNameAr;
  final String email;

  UpdateAccountProfile({
    required this.firstNameAr,
    required this.lastNameAr,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "first_name_ar": firstNameAr,
        "last_name_ar": lastNameAr,
        "email": email,
        "_method": 'PUT'
      };
}
