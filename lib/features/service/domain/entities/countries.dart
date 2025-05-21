import 'package:app/features/service/data/models/get_all_countries_response/city.dart';
import 'package:app/features/service/domain/entities/cities.dart';

class Countries {
  final int id;
  final String name;
  final List<Cities> cities;
  Countries({required this.id, required this.name, required this.cities});
}
