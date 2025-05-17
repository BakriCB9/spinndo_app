class ClientProfile {
  final String firstNameAr;
  final String lastNameAr;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final dynamic imagePath;
  final int id;

  const ClientProfile({
    required this.id,
    required this.firstNameAr,
    required this.lastNameAr,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.imagePath,
  });
}
