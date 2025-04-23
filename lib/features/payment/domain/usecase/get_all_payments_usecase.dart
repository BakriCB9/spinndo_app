import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/domain/repositry/payments_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/apiResult.dart';

@lazySingleton
class GetAllPaymentsUseCase {
  PaymentsRepository repository;
  GetAllPaymentsUseCase(this.repository);
  Future<ApiResult<List<PaymentMethodModel>>> call() async {
    ApiResult<List<PaymentMethodModel>> ans = await repository.getAllPaymentsMethods();
    return ans;
  }
}


