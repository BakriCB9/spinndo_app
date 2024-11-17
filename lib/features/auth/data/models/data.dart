import 'package:snipp/features/auth/domain/entities/user.dart';

class Data extends User {
  Data(
      {required super.id,
      required super.isApproved,
      required super.role,
      required super.token});
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as dynamic,
        role: json['role'] as String,
        isApproved: json['isApproved'] as dynamic,
        token: json['token'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'isApproved': isApproved,
        'token': token,
      };
}
