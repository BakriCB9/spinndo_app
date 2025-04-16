import 'package:app/core/error/apiResult.dart';
import 'package:app/features/discount/domain/repositry/discount_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteDiscountUseCase {
  DiscountRepo _discountRepo;
  DeleteDiscountUseCase(this._discountRepo);
  Future<ApiResult<String>> call(int userId) =>
      _discountRepo.deleteDiscount(userId);
}
