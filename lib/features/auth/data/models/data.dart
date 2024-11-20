
class Data  {

  final dynamic id;
  final String role;
  final dynamic isApproved;
  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as dynamic,
        role: json['role'] as String,
        isApproved: json['isApproved'] as dynamic,
        token: json['token'] as String,
      );

  Data({required this.id, required this.role, required this.isApproved, required this.token});

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'isApproved': isApproved,
        'token': token,
      };
}
