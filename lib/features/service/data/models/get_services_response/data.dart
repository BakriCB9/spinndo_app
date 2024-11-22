import 'category.dart';

class Data {
	int? id;
	String? name;
	String? description;
	dynamic website;
	String? longitude;
	String? latitude;
	Category? category;
	int? providerId;
	String? providerName;
	dynamic providerImage;

	Data({
		this.id, 
		this.name, 
		this.description, 
		this.website, 
		this.longitude, 
		this.latitude, 
		this.category, 
		this.providerId, 
		this.providerName, 
		this.providerImage, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				name: json['name'] as String?,
				description: json['description'] as String?,
				website: json['website'] as dynamic,
				longitude: json['longitude'] as String?,
				latitude: json['latitude'] as String?,
				category: json['category'] == null
						? null
						: Category.fromJson(json['category'] as Map<String, dynamic>),
				providerId: json['provider_id'] as int?,
				providerName: json['provider_name'] as String?,
				providerImage: json['provider_image'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'description': description,
				'website': website,
				'longitude': longitude,
				'latitude': latitude,
				'category': category?.toJson(),
				'provider_id': providerId,
				'provider_name': providerName,
				'provider_image': providerImage,
			};
}
