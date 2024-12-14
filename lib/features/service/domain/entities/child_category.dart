class ChildCategory {
  int? id;
  String? name;

  ChildCategory({this.id, this.name});

  factory ChildCategory.fromJson(Map<String, dynamic> json) => ChildCategory(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}