import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_details_job.dart';

class ProviderProfile {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic imagePath;
  ProviderProfileDetailsJob? details;
  ProviderProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.imagePath,
    this.details,
  });
}
