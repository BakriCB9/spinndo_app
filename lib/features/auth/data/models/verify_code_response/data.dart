class Data {
  int? id;
  String? role;
  String? token;

  Data({this.id, this.role, this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        role: json['role'] as String?,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'token': token,
      };
}
