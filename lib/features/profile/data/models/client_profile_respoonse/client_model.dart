import 'package:app/features/profile/domain/entities/client_profile.dart';

class ClientModel extends ClientProfile {
  const ClientModel({
    required super.firstNameAr,
    required super.lastNameAr,
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phone,
    super.imagePath,
  });

  @override
  String toString() {
    return 'Data(id: $id, firstName: $firstName, lastName: $lastName, email: $email, imagePath: $imagePath,phone:$phone)';
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      ClientModel(
        id: json['id'] as int,
        firstNameAr: json['first_name_ar'] as String,
        lastNameAr: json['last_name_ar'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        email: json['email'] as String,
        imagePath: json['image_path'] as dynamic,
        phone: json['phone'] as String,
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'image_path': imagePath,
      };
}
