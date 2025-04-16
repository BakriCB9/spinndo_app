import 'package:app/core/constant.dart';
import 'package:app/features/service_requist/data/dataSource/remote/service_requist_remote_dataSource.dart';
import 'package:app/features/service_requist/data/model/request_model/update_my_service_request.dart';
import 'package:app/features/service_requist/data/model/response_model/get_all_service_request_model/datum.dart';
import 'package:app/features/service_requist/data/model/response_model/get_all_service_request_model/get_all_service_request_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ServiceRequistRemoteDatasource)
class ServiceRequestRemoteDatasouceImpl extends ServiceRequistRemoteDatasource {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  ServiceRequestRemoteDatasouceImpl(this._dio, this._sharedPreferences);
  @override
  Future<String> closeMyserviceRequest(String idOfSerivce) async {
    return 'kk';
  }

  @override
  Future<String> deleteMyService(int idOfSerivce) async {
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final lang = _sharedPreferences.getString('language');

    final ans =
        await _dio.delete(ApiConstant.SericeRequestOrder + '/$idOfSerivce',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $userToken",
              "Accept-Language": '$lang'
            }));
    return ans.data["message"];
  }

  @override
  Future<List<DataOfAllServiceRequest>> getAllRequest() async {
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final lang = _sharedPreferences.getString('language');

    final ans = await _dio.get(ApiConstant.SericeRequestOrder,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "Accept-Language": '$lang'
        }));

    return GetAllServiceRequestModel.fromJson(ans.data).data ?? [];
  }

  @override
  Future<List<DataOfAllServiceRequest>> getMyServiceRequestOnly(
      int userId) async {
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final lang = _sharedPreferences.getString('language');
    final ans = await _dio.get(ApiConstant.SericeRequestOrder,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "Accept-Language": '$lang'
        }),
        data: {"user_id": userId});
    return GetAllServiceRequestModel.fromJson(ans.data).data ?? [];
  }

  @override
  Future<DataOfAllServiceRequest> updateMyRequest(
      int idOfSerivce, MyServiceRequest myservice) async {
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final lang = _sharedPreferences.getString('language');
    print('the id of service is $idOfSerivce');
    print(
        'the object is ${myservice.title} and descrip is ${myservice.desCription}');
    final nameofbath = idOfSerivce.toString();
    final ans =
        await _dio.put(ApiConstant.SericeRequestOrder + '/${idOfSerivce}',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $userToken",
              "Accept-Language": '$lang'
            }),
            data: myservice.toJson());
    print('bakkkar al malek is herree ');
    return DataOfAllServiceRequest.fromJson(ans.data);
  }

  @override
  Future<DataOfAllServiceRequest> create(
      MyServiceRequest myServiceRequest) async {
    final userToken = _sharedPreferences.getString(CacheConstant.tokenKey);
    final lang = _sharedPreferences.getString('language');
    final ans = await _dio.post(ApiConstant.SericeRequestOrder,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken",
          "Accept-Language": '$lang'
        }),
        data: myServiceRequest.toJson());
    print('');
    print('the data from api is now ${ans.data["data"]}');
    print('');
    return DataOfAllServiceRequest.fromJson(ans.data["data"]);
  }
}
