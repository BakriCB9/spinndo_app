import 'package:snipp/features/service/domain/entities/countries.dart';
import 'city.dart';

class Data extends Countries {

	Data({required super.name, required super.cities, required super.id});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
		id: json['id'] as int,
		name: json['name'] as String,
		cities: (json['cities'] as List<dynamic>)
				.map((e) => City.fromJson(e as Map<String, dynamic>))
				.toList(),
	);



}
