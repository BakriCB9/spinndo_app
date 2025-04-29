import 'package:app/core/constant.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/data/model/subscription/payment_response.dart';
import 'package:app/features/payment/data/model/subscription/refund_response.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'payements_remote_datasource.dart';

@Injectable(as: PaymentsRemoteDatasource)
class PaymentsRemoteDatasourceImpl extends PaymentsRemoteDatasource {
  final Dio _dio;
  PaymentsRemoteDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<PaymentMethodModel>> getAllMethods(String userToken) async {
    final ans = await _dio.get(ApiConstant.getAllPaymentsMethod,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));

    final List<dynamic> data = ans.data['data'];
    return data.map((json) => PaymentMethodModel.fromJson(json)).toList();
  }

  @override
  Future<PaymentResponse?> createPaymentMethod(PaymentMethodModel payment, String userToken) async{
    final ans = await _dio.post(
      ApiConstant.addPaymentMethod,
      data: payment.toJson(),
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      }),
    );

    if (ans.statusCode == 200) {
      print('تمت إضافة طريقة الدفع بنجاح');
    } else {
      print('فشل إضافة طريقة الدفع: ${ans.statusCode}');
    }

    print("Raw response: ${ans.data}");

    final parsed = PaymentResponse.fromJson(ans.data);
    return parsed;
  }

  @override
  Future<RefundResponse?> refund(String payment_intent_id, String userToken) async{
    try {
      final response = await _dio.post(
        '/subscriptions/refund/$payment_intent_id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $userToken',
          },
        ),
      );

      return RefundResponse.fromJson(response.data);
    } catch (e) {
      print('Error during unsubscribe: $e');
      return null;
    }
  }


}