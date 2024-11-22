import 'data.dart';

class GetAllCountriesResponse {
	String? status;
	String? message;
	List<Data>? data;

	GetAllCountriesResponse({this.status, this.message, this.data});

	factory GetAllCountriesResponse.fromJson(Map<String, dynamic> json) {
		return GetAllCountriesResponse(
			status: json['status'] as String?,
			message: json['message'] as String?,
			data: (json['data'] as List<dynamic>?)
						?.map((e) => Data.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'status': status,
				'message': message,
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
