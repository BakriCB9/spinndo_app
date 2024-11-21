import 'package:snipp/features/profile/domain/entities/provider_profile/provider_priofile_workingday.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_category.dart';
import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_image.dart';

class ProviderProfileDetailsJob {
  int? id;
  String? name;
  String? description;
  dynamic website;
  String? longitude;
  String? latitude;
  dynamic isApproved;
  String? certificatePath;
  ProviderProfileCategory? category;
  dynamic city;
  List<ProviderPriofileWorkingday>? workingDays;
  List<ProviderProfileImage>? images;

  ProviderProfileDetailsJob({
    this.id,
    this.name,
    this.description,
    this.website,
    this.longitude,
    this.latitude,
    this.isApproved,
    this.certificatePath,
    this.category,
    this.city,
    this.workingDays,
    this.images,
  });
}