import 'datum.dart';

class NotificationModel {
  String? status;
  String? message;
  List<NotificationData>? data;

  NotificationModel({this.status, this.message, this.data});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
