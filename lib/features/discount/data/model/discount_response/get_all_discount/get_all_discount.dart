import 'package:app/features/discount/data/model/discount_response/get_all_discount/data_of_discount.dart';

class GetAllDiscountResponse {
  String? status;
  String? message;
  List<DataOfDiscount>? data;

  GetAllDiscountResponse({this.status, this.message, this.data});

  factory GetAllDiscountResponse.fromJson(Map<String, dynamic> json) {
    return GetAllDiscountResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataOfDiscount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
