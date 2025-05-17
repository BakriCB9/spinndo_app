import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_details_job.dart';
import 'package:app/features/profile/domain/entities/provider_profile_social_links.dart';

class ProviderProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? firstNameAr;
  String? lastNameAr;
  String? email;
  String? phone;
  dynamic imagePath;
  List<ProviderProfileSocialLinks?>? socialLinks;
  ProviderProfileDetailsJob? details;
  ProviderProfile({
    this.id,
    this.firstName,
    this.firstNameAr,
    this.lastNameAr,
    this.lastName,
    this.email,
    this.phone,
    this.imagePath,
    this.socialLinks,
    this.details,
  }) {
    print('we create provider profile now');
    print('the social linke of list is ${socialLinks}');
    // print('the social linke of list is ${socialLinks?[0].platform}');
  }
}
