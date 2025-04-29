


import 'package:app/core/constant.dart';
import 'package:app/core/error/apiResult.dart';
import 'package:app/features/payment/data/data_source/remote/payements_remote_datasource.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/data/model/subscription/payment_response.dart';
import 'package:app/features/payment/data/model/subscription/refund_response.dart';
import 'package:app/features/payment/domain/repositry/payments_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: PaymentsRepository)
class PaymentsMethodImpl extends PaymentsRepository {
  late PaymentsRemoteDatasource methodsRemoteDataSource;
  final PaymentsRemoteDatasource addPaymentsRemoteDatasource;
  final PaymentsRemoteDatasource returnPaymentsRemoteDatasource;


  late SharedPreferences sharedPreferences;

  PaymentsMethodImpl(this.methodsRemoteDataSource, this.sharedPreferences,
      this.addPaymentsRemoteDatasource, this.returnPaymentsRemoteDatasource);

  @override
  Future<ApiResult<List<PaymentMethodModel>>> getAllPaymentsMethods() async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      final ans = await methodsRemoteDataSource.getAllMethods(userToken!);
      print('');
      print('the value of package in repository is $ans');
      print('');
      return ApiResultSuccess<List<PaymentMethodModel>>(ans);
    } catch (e) {
      return ApiresultError<List<PaymentMethodModel>>('Failed to get packages');
    }
  }


  @override
  Future<ApiResult<PaymentResponse>> addPaymentMethod(PaymentMethodModel method) async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      if (userToken == null) {
        return ApiresultError<PaymentResponse>("User token is missing");
      }

      final response = await addPaymentsRemoteDatasource.createPaymentMethod(
          method, userToken);

      if (response == null) {
        return ApiresultError<PaymentResponse>(
            'Subscription failed: No response data');
      }

      print("TOKEN is: $userToken");
      print('Subscription successfully added');

      return ApiResultSuccess<PaymentResponse>(response);
    } catch (exception) {
      print('Error occurred: $exception');
      var message = 'Failed to add subscription';

      if (exception is DioException) {
        print('DioException occurred: $exception');

        if (exception.type == DioExceptionType.badResponse) {
          message = 'Server error';
        } else {
          final errorMessage = exception.response?.data['message'];
          if (errorMessage != null) message = errorMessage;
        }
      }

      return ApiresultError<PaymentResponse>(message);
    }
  }

  @override
  Future<ApiResult<RefundResponse>> refundResponse(String payment_intent_id) async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      if (userToken == null) {
        return ApiresultError<RefundResponse>("User token is missing");
      }

      final response = await returnPaymentsRemoteDatasource.refund(payment_intent_id, userToken);

      if (response == null) {
        return ApiresultError<RefundResponse>('Unsubscription failed: No response data');
      }

      print("TOKEN is: $userToken");
      print('Unsubscription successfully added');

      return ApiResultSuccess<RefundResponse>(response);
    } catch (exception) {
      print('Error occurred: $exception');
      var message = 'Failed to add unsubscription';

      if (exception is DioException) {
        print('DioException occurred: $exception');

        if (exception.type == DioExceptionType.badResponse) {
          message = 'Server error';
        } else {
          final errorMessage = exception.response?.data['message'];
          if (errorMessage != null) message = errorMessage;
        }
      }

      return ApiresultError<RefundResponse>(message);
    }
  }




}