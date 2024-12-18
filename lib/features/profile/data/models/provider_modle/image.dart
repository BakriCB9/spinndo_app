import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_image.dart';

class Image  extends ProviderProfileImage{


	Image({super.path});

	factory Image.fromJson(Map<String, dynamic> json) => Image(
				path: json['path'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'path': path,
			};
}
