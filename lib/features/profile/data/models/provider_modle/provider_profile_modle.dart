import 'data.dart';

class ProviderProfileResponse {
	String? status;
	String? message;
	Data? data;

	ProviderProfileResponse({this.status, this.message, this.data});

	factory ProviderProfileResponse.fromJson(Map<String, dynamic> json) => ProviderProfileResponse(
				status: json['status'] as String?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);


}
