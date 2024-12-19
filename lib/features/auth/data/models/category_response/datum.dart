import 'child.dart';

class Data {
  int? id;
  String? name;
  List<Child>? children;

  Data({this.id, this.name, this.children});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
