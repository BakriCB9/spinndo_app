class User {
  final int id;
  final String role;
  final bool? isApproved;
  final String token;

  User({
    required this.id,
    required this.role,
    this.isApproved,
    required this.token,
  });
}
