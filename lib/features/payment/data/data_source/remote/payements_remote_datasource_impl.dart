import 'package:app/core/constant.dart';
import 'package:app/features/payment/data/model/payments_model.dart';

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
}