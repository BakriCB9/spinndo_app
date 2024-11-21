class Category {
	int? id;
	String? name;
	dynamic hasChildren;

	Category({this.id, this.name, this.hasChildren});

	factory Category.fromJson(Map<String, dynamic> json) => Category(
				id: json['id'] as int?,
				name: json['name'] as String?,
				hasChildren: json['has_children'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'has_children': hasChildren,
			};
}
