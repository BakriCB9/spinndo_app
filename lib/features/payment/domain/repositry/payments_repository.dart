import 'package:app/features/payment/data/model/payments_model.dart';
import '../../../../core/error/apiResult.dart';


abstract class PaymentsRepository {
  Future<ApiResult<List<PaymentMethodModel>>> getAllPaymentsMethods();
}