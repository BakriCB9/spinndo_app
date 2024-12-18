import 'provider_profile.dart';

class ProviderProfileResponse {
  String? status;
  String? message;
  ProviderProfile? data;

  ProviderProfileResponse({this.status, this.message, this.data});

  factory ProviderProfileResponse.fromJson(Map<String, dynamic> json) => ProviderProfileResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : ProviderProfile.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
