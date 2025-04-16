import 'package:app/features/profile/domain/entities/provider_profile/provider_porfile_category.dart';



class Category extends ProviderProfileCategory {
  Category({super.id, super.name, super.parent});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      parent: json['parent'] == null
          ? null
          : Category.fromJson(json['parent'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        //'parent': parent?.toJson(),
      };
}
