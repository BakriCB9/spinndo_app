class UpdateAccountProfile {
  final String firstName;
  final String lastName;
  final String firstNameAr;
  final String lastNameAr;
  UpdateAccountProfile(
      {required this.firstNameAr,
      required this.lastNameAr,
      required this.firstName,
      required this.lastName});
  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "first_name_ar": firstNameAr,
        "last_name_ar": lastNameAr,
        "_method": 'PUT'
      };
}
