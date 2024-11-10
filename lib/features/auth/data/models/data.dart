class Data {
  int? id;
  String? role;
  String? token;
  dynamic isApproved;

  Data({this.id, this.role, this.token,this.isApproved});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        role: json['role'] as String?,
    isApproved: json['isApproved'] as dynamic,

        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
    'isApproved': isApproved,

        'token': token,
      };
}
