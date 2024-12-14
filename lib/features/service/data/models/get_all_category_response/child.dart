class Child {
  int? id;
  String? name;

  Child({this.id, this.name});

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}