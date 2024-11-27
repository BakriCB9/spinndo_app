import 'data.dart';

class GetServicesResponse {
  String? status;
  String? message;
  List<Data>? data;

  GetServicesResponse({this.status, this.message, this.data});

  factory GetServicesResponse.fromJson(Map<String, dynamic> json) {
    return GetServicesResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
