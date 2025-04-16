import 'package:app/core/constant.dart';
import 'package:app/features/discount/data/dataSource/remote/remote_dataSource.dart';
import 'package:app/features/discount/data/model/discount_request/add_discount_request.dart';
import 'package:app/features/discount/data/model/discount_response/get_all_discount/get_all_discount.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: DiscountRemoteDataSource)
class DiscountRemoteDatasourceImpl implements DiscountRemoteDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;
  DiscountRemoteDatasourceImpl(this._dio, this._sharedPreferences);
  @override
  Future<String> addDiscount(AddDiscountRequest addDiscount) async {
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final ans = await _dio.post(ApiConstant.addDiscount,
        data: addDiscount.toJson(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
        }));
    return ans.data["message"];
  }

  @override
  Future<String> deleteDiscount(int userId) async {
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final ans = await _dio.put(ApiConstant.deleteDiscount,
        data: {"user_id": userId},
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
        }));
    return ans.data["message"];
  }

  @override
  Future<GetAllDiscountResponse> getAllDiscount() async {
    final lang = _sharedPreferences.getString('language');
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final ans = await _dio.get(ApiConstant.getAllDiscount,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "Accept-Language": '$lang'
        }));
    return GetAllDiscountResponse.fromJson(ans.data);
  }
}
