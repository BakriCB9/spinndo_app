import 'package:app/core/error/apiResult.dart';
import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/domain/entity/all_discount_entity.dart';

abstract class DiscountRepo {
  Future<ApiResult<String>> addDiscount(AddDiscountRequest addDiscount);
  Future<ApiResult<String>> deleteDiscount(int userId);
  Future<ApiResult<List<AllDiscountEntity>>> getAllDiscount();
}
