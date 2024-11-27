import 'package:snipp/features/service/domain/entities/categories.dart';

class Data extends Categories {
  final List<dynamic>? children;

  Data({required super.id, required super.name, this.children});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int,
        name: json['name'] as String,
        children: json['children'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'children': children,
      };
}
