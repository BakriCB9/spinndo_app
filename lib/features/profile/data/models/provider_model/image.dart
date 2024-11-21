import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_image.dart';

class ImagesPath  extends ProviderProfileImage{
	// String? path;

	ImagesPath({super.path});

	factory ImagesPath.fromJson(Map<String, dynamic> json) => ImagesPath(
				path: json['path'] as String?,
			);
}