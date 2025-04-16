import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_parent.dart';

class Parent extends PorfivderPorfileParent {
  int? id;
  String? name;
  dynamic parent;
  
  Parent({this.id, this.name, this.parent});

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        id: json['id'] as int?,
        name: json['name'] as String?,
        parent: json['parent'] as dynamic,
      );
}
