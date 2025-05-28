import 'package:app/features/profile/domain/entities/provider_profile/provider_porfile_category.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_priofile_workingday.dart';

import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_city.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_image.dart';

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
  bool? isopen;
  String? accountStatus;
//  dynamic city;
  List<ProviderPriofileWorkingday>? workingDays;
  List<ProviderProfileImage>? images;

  ProviderProfileCity? city;

  ProviderProfileDetailsJob({
    this.images,
    this.category,
    this.city,
    this.id,
    this.name,
    this.description,
    this.website,
    this.longitude,
    this.latitude,
    this.isApproved,
    this.certificatePath,
    this.isopen,
    this.workingDays,
    this.accountStatus
  });
}
