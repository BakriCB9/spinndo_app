import 'package:app/features/service/domain/entities/countries.dart';
import 'city.dart';

class DataCountries extends Countries {
  DataCountries(
      {required super.name, required super.cities, required super.id});

  factory DataCountries.fromJson(Map<String, dynamic> json) => DataCountries(
        id: json['id'] as int,
        name: json['name'] as String,
        cities: (json['cities'] as List<dynamic>)
            .map((e) => City.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
