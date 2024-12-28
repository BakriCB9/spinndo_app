class ClientProfile {
  final String firstName;
  final String lastName;
  final String email;
  final dynamic imagePath;
  final int id;

  const ClientProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.imagePath,
  });
}
