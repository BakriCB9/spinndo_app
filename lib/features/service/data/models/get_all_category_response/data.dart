import 'package:app/features/auth/data/models/category_response/child.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/child_category.dart';

class DataCategory extends Categories {
  DataCategory({required super.id, required super.name, required super.children});

  factory DataCategory.fromJson(Map<String, dynamic> json) => DataCategory(
        id: json['id'] as int,
        name: json['name'] as String,
        children: (json['children'] as List<dynamic>)
            .map((e) => ChildCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'children': children,
      };
}
