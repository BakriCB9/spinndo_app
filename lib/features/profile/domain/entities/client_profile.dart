class ClientProfile {

  final String firstName;
  final String lastName;
  final String email;
  final dynamic imagePath;

  const ClientProfile({
  required this.firstName,
  required this.lastName,
  required this.email,
  this.imagePath,
  });

  }