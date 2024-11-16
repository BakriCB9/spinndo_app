

import 'client_model.dart';

class ClientProfileRespoonse {
  final String? status;
  final String? message;
  final ClientModel? data;

  const ClientProfileRespoonse({this.status, this.message, this.data});

  @override
  String toString() {
    return 'ProfileRespoonse(status: $status, message: $message, data: $data)';
  }

  factory ClientProfileRespoonse.fromJson(Map<String, dynamic> json) {
    return ClientProfileRespoonse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ClientModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
