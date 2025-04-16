import 'package:app/core/error/apiResult.dart';
import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/domain/repositry/discount_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddDiscountUseCase {
  DiscountRepo _discountRepo;
  AddDiscountUseCase(this._discountRepo);
  Future<ApiResult<String>> call(AddDiscountRequest addDiscount) =>
      _discountRepo.addDiscount(addDiscount);
}
