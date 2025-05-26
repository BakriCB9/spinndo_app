import 'package:app/features/profile/data/models/provider_modle/social_links.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_details_job.dart';
import 'package:app/features/profile/domain/entities/provider_profile_social_links.dart';
import 'details.dart';

class Data extends ProviderProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  dynamic imagePath;
  List<ProviderProfileSocialLinks?>? socialLinks;
  ProviderProfileDetailsJob? details;
  String? firstNameAr;
  String? lastNameAr;
  String? accountStatus;

  Data(
      {this.id,
      this.socialLinks,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.email,
      this.imagePath,
      this.details,
      this.firstNameAr,
      this.lastNameAr,
        this.accountStatus
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int?,
      firstNameAr: json['first_name_ar'] as String,
      lastNameAr: json['last_name_ar'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone'] as String?,
      email: json['email'] as String?,
      accountStatus: json['account_status'] as String?,
      imagePath: json['image_path'] as dynamic,
      socialLinks: (json['socialLinks'] != null &&
              json['socialLinks'] is List &&
              (json['socialLinks'] as List).isNotEmpty)
          ? (json['socialLinks'] as List)
              .map((e) => SocialLinks.fromJson(e as Map<String, dynamic>))
              .toList()
          : <SocialLinks>[],
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
    );
  }
}
