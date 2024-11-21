import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile.dart';

import 'details.dart';

class Data extends ProviderProfile {
	Data({super.id,
		super.firstName,
		super.lastName,
		super.email,
		super.imagePath,
		super.details,
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				firstName: json['first_name'] as String?,
				lastName: json['last_name'] as String?,
				email: json['email'] as String?,
				imagePath: json['image_path'] as dynamic,
				details: json['details'] == null
						? null
						: Details.fromJson(json['details'] as Map<String, dynamic>),
			);


}
