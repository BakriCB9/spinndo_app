import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/data/model/subscription/payment_response.dart';
import 'package:app/features/payment/data/model/subscription/refund_response.dart';
import '../../../../core/error/apiResult.dart';


abstract class PaymentsRepository {
  Future<ApiResult<List<PaymentMethodModel>>> getAllPaymentsMethods();
  Future<ApiResult<PaymentResponse>> addPaymentMethod(PaymentMethodModel method);
  Future<ApiResult<RefundResponse>> refundResponse(String paymentIntentId);

}