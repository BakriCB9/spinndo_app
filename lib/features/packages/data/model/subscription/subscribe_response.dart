import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';

class SubscribeResponse {
  final String status;
  final String message;
  final SubscribeModel data;

  SubscribeResponse({required this.status, required this.message, required this.data});

  factory SubscribeResponse.fromJson(Map<String, dynamic> json) {
    return SubscribeResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] as SubscribeModel,
    );
  }


  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "message": message,
        "data": data,
      };

}
