import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/data/model/discount_response/get_all_discount/get_all_discount.dart';

abstract class DiscountRemoteDataSource {
  Future<String> addDiscount(AddDiscountRequest addDiscount);
  Future<GetAllDiscountResponse> getAllDiscount();
  Future<String> deleteDiscount(int userId);
}
