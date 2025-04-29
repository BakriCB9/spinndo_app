import 'package:app/features/payment/data/model/payments_model.dart';

class PaymentResponse {
  final String status;
  final String message;
  final PaymentMethodModel data;

  PaymentResponse({required this.status, required this.message, required this.data});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      status: json['status'],
      message: json['message'],
      data: PaymentMethodModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.toJson(),
    };
  }
}
