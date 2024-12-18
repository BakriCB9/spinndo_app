import 'details.dart';

class ProviderProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic imagePath;
  Details? details;

  ProviderProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.imagePath,
    this.details,
  });

  factory ProviderProfile.fromJson(Map<String, dynamic> json) => ProviderProfile(
        id: json['id'] as int?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        email: json['email'] as String?,
        imagePath: json['image_path'] as dynamic,
        details: json['details'] == null
            ? null
            : Details.fromJson(json['details'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'image_path': imagePath,
        'details': details?.toJson(),
      };
}
