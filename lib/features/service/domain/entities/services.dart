import 'package:app/features/service/domain/entities/categories.dart';

class Services {
  final int? providerId;
  final int? id;
  final String? name;
  final String? description;
  final dynamic website;
  final String? longitude;
  final String? latitude;
  final String? categoryName;
  final String? providerName;
  final dynamic providerImage;

  Services(
      {required this.id,
      required this.providerId,
      required this.name,
      required this.description,
      required this.website,
      required this.longitude,
      required this.latitude,
      required this.categoryName,
      required this.providerName,
      required this.providerImage});
}
