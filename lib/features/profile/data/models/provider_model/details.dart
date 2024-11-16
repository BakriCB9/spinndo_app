import 'category.dart';
import 'image.dart';
import 'working_day.dart';

class Details {
	int? id;
	String? name;
	String? description;
	dynamic website;
	String? longitude;
	String? latitude;
	int? isApproved;
	String? certificatePath;
	Category? category;
	dynamic city;
	List<WorkingDay>? workingDays;
	List<ImagesPath>? images;

	Details({
		this.id, 
		this.name, 
		this.description, 
		this.website, 
		this.longitude, 
		this.latitude, 
		this.isApproved, 
		this.certificatePath, 
		this.category, 
		this.city, 
		this.workingDays, 
		this.images, 
	});

	factory Details.fromJson(Map<String, dynamic> json) => Details(
				id: json['id'] as int?,
				name: json['name'] as String?,
				description: json['description'] as String?,
				website: json['website'] as dynamic,
				longitude: json['longitude'] as String?,
				latitude: json['latitude'] as String?,
				isApproved: json['is_approved'] as int?,
				certificatePath: json['certificate_path'] as String?,
				category: json['category'] == null
						? null
						: Category.fromJson(json['category'] as Map<String, dynamic>),
				city: json['city'] as dynamic,
				workingDays: (json['working_days'] as List<dynamic>?)
						?.map((e) => WorkingDay.fromJson(e as Map<String, dynamic>))
						.toList(),
				images: (json['images'] as List<dynamic>?)
						?.map((e) => ImagesPath.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'description': description,
				'website': website,
				'longitude': longitude,
				'latitude': latitude,
				'is_approved': isApproved,
				'certificate_path': certificatePath,
				'category': category?.toJson(),
				'city': city,
				'working_days': workingDays?.map((e) => e.toJson()).toList(),
				'images': images?.map((e) => e.toJson()).toList(),
			};
}
