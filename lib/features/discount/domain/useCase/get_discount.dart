import 'package:app/core/error/apiResult.dart';
import 'package:app/features/discount/domain/entity/all_discount_entity.dart';
import 'package:app/features/discount/domain/repositry/discount_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllDiscountUseCase {
  DiscountRepo _discountRepo;
  GetAllDiscountUseCase(this._discountRepo);
  Future<ApiResult<List<AllDiscountEntity>>> call() =>
      _discountRepo.getAllDiscount();
}
