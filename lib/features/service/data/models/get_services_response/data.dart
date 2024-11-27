import 'package:snipp/features/service/domain/entities/services.dart';


class Data extends Services {

	Data({required super.name, required super.description, required super.website, required super.longitude, required super.latitude, required super.categoryName, required super.providerName, required super.providerImage, required super.id, required super.providerId});



	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				name: json['name'] as String?,
				description: json['description'] as String?,
				website: json['website'] as dynamic,
				longitude: json['longitude'] as String?,
				latitude: json['latitude'] as String?,
				categoryName: json['category'] ['name']as String?,
				providerId: json['provider_id'] as int?,
				providerName: json['provider_name'] as String?,
				providerImage: json['image'] as dynamic,
			);



}
