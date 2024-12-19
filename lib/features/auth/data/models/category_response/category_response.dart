import 'datum.dart';

class CategoryResponse {
  String? status;
  String? message;
  List<Data>? data;

  CategoryResponse({this.status, this.message, this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
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
