import 'provider_profile_parent.dart';

class ProviderProfileCategory {
  int? id;
  String? name;
  ProviderProfileParent? parent;

  ProviderProfileCategory({this.id, this.name, this.parent});

  factory ProviderProfileCategory.fromJson(Map<String, dynamic> json) => ProviderProfileCategory(
        id: json['id'] as int?,
        name: json['name'] as String?,
        parent: json['parent'] == null
            ? null
            : ProviderProfileParent.fromJson(json['parent'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'parent': parent?.toJson(),
      };
}
