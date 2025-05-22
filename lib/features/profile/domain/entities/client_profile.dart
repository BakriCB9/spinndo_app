class ClientProfile {
  final String firstNameAr;
  final String lastNameAr;
  final String firstName;
  final String lastName;
  final String email;
  final dynamic imagePath;
  final int id;
  final String phoneNumber;

  const ClientProfile({
    required this.id,
    required this.phoneNumber,
    required this.firstNameAr,
    required this.lastNameAr,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.imagePath,
  });
}
