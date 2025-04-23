import 'package:app/features/payment/data/model/payments_model.dart';
abstract class PaymentsRemoteDatasource {
  Future<List<PaymentMethodModel>> getAllMethods(String userToken);
}
