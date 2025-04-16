import 'package:app/core/error/apiResult.dart';
import 'package:app/features/discount/data/dataSource/remote/remote_dataSource.dart';
import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/domain/entity/all_discount_entity.dart';
import 'package:app/features/discount/domain/repositry/discount_repo.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DiscountRepo)
class DiscountRepoImpl implements DiscountRepo {
  DiscountRemoteDataSource _discountRemoteDataSource;
  DiscountRepoImpl(this._discountRemoteDataSource);
  @override
  Future<ApiResult<String>> addDiscount(AddDiscountRequest addDiscount) async {
    try {
      final ans = await _discountRemoteDataSource.addDiscount(addDiscount);
      print('yes it add now bakkkar');
      return ApiResultSuccess<String>(ans);
    } catch (exception) {
      print(
          'it is fail now rohhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhi');
      var message = 'Failed to add Discount';

      if (exception is DioException) {
        print('it is dioException now $exception');

        if (exception.type == DioExceptionType.badResponse) {
          message = 'server error';
        } else {
          final errorMessage = exception.response?.data['message'];

          if (errorMessage != null) message = errorMessage;
        }
      }
      print('the message is now is $message');
      return ApiresultError<String>(message);
    }
  }

  @override
  Future<ApiResult<String>> deleteDiscount(int userId) async {
    try {
      final ans = await _discountRemoteDataSource.deleteDiscount(userId);
      return ApiResultSuccess<String>(ans);
    } catch (exception) {
      var message = 'Failed to delete Discount';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      return ApiresultError<String>(message);
    }
  }

  @override
  Future<ApiResult<List<AllDiscountEntity>>> getAllDiscount() async {
    try {
      final ans = await _discountRemoteDataSource.getAllDiscount();
      final aux = ans.data?.map((e) {
        return e.toAllDiscountEntity();
      }).toList();
      return ApiResultSuccess<List<AllDiscountEntity>>(aux ?? []);
    } catch (exception) {
      var message = 'Failed to add Discount';
      if (exception is DioException) {
        final errorMessage = exception.response?.data['message'];

        if (errorMessage != null) message = errorMessage;
      }
      return ApiresultError<List<AllDiscountEntity>>(message);
    }
  }
}
