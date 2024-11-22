import 'city.dart';

class Data {
	int? id;
	String? name;
	List<City>? cities;

	Data({this.id, this.name, this.cities});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				name: json['name'] as String?,
				cities: (json['cities'] as List<dynamic>?)
						?.map((e) => City.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'cities': cities?.map((e) => e.toJson()).toList(),
			};
}
