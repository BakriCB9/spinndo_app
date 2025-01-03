import 'data.dart';

class GetAllCategoryResponse {
  String? status;
  String? message;
  List<DataCategory>? data;

  GetAllCategoryResponse({this.status, this.message, this.data});

  factory GetAllCategoryResponse.fromJson(Map<String, dynamic> json) {
    return GetAllCategoryResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
