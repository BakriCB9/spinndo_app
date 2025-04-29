import 'package:app/core/error/apiResult.dart';
import 'package:app/features/favorite/domain/repositry/fav_repositry.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';
import 'package:app/features/packages/domain/repositry/package_repository.dart';
import 'package:app/features/payment/data/model/payments_model.dart';
import 'package:app/features/payment/data/model/subscription/payment_response.dart';
import 'package:app/features/payment/domain/repositry/payments_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddPaymentMethodUseCase {
  PaymentsRepository addPaymentMethodrepository;
  AddPaymentMethodUseCase(this.addPaymentMethodrepository);
  Future<ApiResult<PaymentResponse?>> call(PaymentMethodModel repository) =>
      addPaymentMethodrepository.addPaymentMethod(repository);
}
