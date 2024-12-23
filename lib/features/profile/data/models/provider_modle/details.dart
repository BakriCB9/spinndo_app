import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_details_job.dart';

import 'category.dart';
import 'city.dart';
import 'image.dart';
import 'working_day.dart';

class Details extends ProviderProfileDetailsJob{

	Details({
		super.id,
		super.name,
		super.description,
		super.website,
		super.longitude,
		super.latitude,
		super.isApproved,
		super.certificatePath,
		super.category,
		super.city,
		super.workingDays,
		super.images,
		super.isopen
	});

	factory Details.fromJson(Map<String, dynamic> json) => Details(
				id: json['id'] as int?,
				name: json['name'] as String?,
				description: json['description'] as String?,
				website: json['website'] as dynamic,
				longitude: json['longitude'] as String?,
				latitude: json['latitude'] as String?,
				isApproved: json['is_approved'] as int?,
				certificatePath: json['certificate_path'] as String?,
		isopen: json['isOpenNow'] as bool ?,
				category: json['category'] == null
						? null
						: Category.fromJson(json['category'] as Map<String, dynamic>),
				city: json['city'] == null
						? null
						: City.fromJson(json['city'] as Map<String, dynamic>),
				workingDays: (json['working_days'] as List<dynamic>?)
						?.map((e) => WorkingDay.fromJson(e as Map<String, dynamic>))
						.toList(),
				images: (json['images'] as List<dynamic>?)
						?.map((e) => Image.fromJson(e as Map<String, dynamic>))
						.toList(),
			);


}
