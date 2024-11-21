import 'data.dart';

class ProviderResponse {
	String? status;
	String? message;
	Data? data;

	ProviderResponse({this.status, this.message, this.data});

	factory ProviderResponse.fromJson(Map<String, dynamic> json) => ProviderResponse(
				status: json['status'] as String?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);

	// Map<String, dynamic> toJson() => {
	// 			'status': status,
	// 			'message': message,
	// 			'data': data?.toJson(),
	// 		};
}
