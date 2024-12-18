import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_city.dart';

class City extends ProviderProfileCity {


	City({super.id, super.name});

	factory City.fromJson(Map<String, dynamic> json) => City(
				id: json['id'] as int?,
				name: json['name'] as String?,
			);


}
