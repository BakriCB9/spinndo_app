class Data {
	int? id;
	String? name;
	List<dynamic>? children;

	Data({this.id, this.name, this.children});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				name: json['name'] as String?,
				children: json['children'] as List<dynamic>?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'children': children,
			};
}
