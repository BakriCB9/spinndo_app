import 'datum.dart';

class GetAllServiceRequestModel {
  String? status;
  String? message;
  List<DataOfAllServiceRequest>? data;

  GetAllServiceRequestModel({this.status, this.message, this.data});

  factory GetAllServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return GetAllServiceRequestModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              DataOfAllServiceRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
