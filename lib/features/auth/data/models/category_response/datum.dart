import 'child.dart';

class DataCategory {
  int? id;
  String? name;
  List<Child>? children;

  DataCategory({this.id, this.name, this.children});

  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
        id: json['id'] as int?,
        name: json['name'] as String?,
        children: (json['children'] as List<dynamic>?)
            ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'children': children?.map((e) => e.toJson()).toList(),
      };
}
