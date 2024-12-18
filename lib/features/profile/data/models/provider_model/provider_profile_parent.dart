class ProviderProfileParent {
  int? id;
  String? name;
  dynamic parent;

  ProviderProfileParent({this.id, this.name, this.parent});

  factory ProviderProfileParent.fromJson(Map<String, dynamic> json) => ProviderProfileParent(
        id: json['id'] as int?,
        name: json['name'] as String?,
        parent: json['parent'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'parent': parent,
      };
}
