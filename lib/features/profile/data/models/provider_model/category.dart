import 'package:snipp/features/profile/domain/entities/provider_profile/provider_profile_category.dart';

class Category extends ProviderProfileCategory{


	Category({super.id, super.name, super.hasChildren});

	factory Category.fromJson(Map<String, dynamic> json) => Category(
				id: json['id'] as int?,
				name: json['name'] as String?,
				hasChildren: json['has_children'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'has_children': hasChildren,
			};
}
