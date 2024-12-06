import 'package:app/features/service/domain/entities/cities.dart';

class City extends Cities {
  City({required super.name, required super.id});

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'] as int,
        name: json['name'] as String,
      );
}
