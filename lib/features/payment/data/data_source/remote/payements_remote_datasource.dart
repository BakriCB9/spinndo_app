import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/data/model/subscription/payment_response.dart';
import 'package:app/features/payment/data/model/subscription/refund_response.dart';

abstract class PaymentsRemoteDatasource {
  Future<List<PaymentMethodModel>> getAllMethods(String userToken);
  Future<PaymentResponse?> createPaymentMethod (PaymentMethodModel payment,String userToken);
  Future<RefundResponse?> refund(String paymentIntentId, String userToken);

}
