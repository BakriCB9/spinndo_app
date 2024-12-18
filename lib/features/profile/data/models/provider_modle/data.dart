import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_details_job.dart';

import 'details.dart';

class Data extends ProviderProfile{
	int? id;
	String? firstName;
	String? lastName;
	String? email;
	dynamic imagePath;
	ProviderProfileDetailsJob? details;

	Data({
		this.id, 
		this.firstName, 
		this.lastName, 
		this.email, 
		this.imagePath, 
		this.details, 
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
