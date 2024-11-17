class User {
  final dynamic id;
  final String role;
  final dynamic isApproved;
  final String token;

  User({
    required this.id,
    required this.role,
    this.isApproved,
    required this.token,
  });
}
