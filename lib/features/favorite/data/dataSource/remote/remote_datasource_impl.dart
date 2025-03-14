import 'package:app/core/constant.dart';
import 'package:app/features/favorite/data/dataSource/remote/remote_datasource.dart';
import 'package:app/features/favorite/data/model/add_fav_response.dart';
import 'package:app/features/service/data/models/get_services_response/get_services_response.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: RemoteDatasource)
class RemoteDatasourceImpl extends RemoteDatasource {
  final Dio _dio;
  RemoteDatasourceImpl({required Dio dio}) : _dio = dio;
  @override
  Future<String?> addToFav(String userId, String userToken) async {
    final ans = await _dio.post(ApiConstant.addTofavorite,
        data: {"user_id": userId},
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));

    print('the ans is $ans');
    return AddFavResponse.fromJson(ans.data).status;
  }

  @override
  Future<String?> removeFromFav(String userId, String userToken) async {
    final ans = await _dio.post(ApiConstant.removeFromFavorite,
        data: {"user_id": userId},
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));

    return AddFavResponse.fromJson(ans.data).status;
  }

  @override
  Future<GetServicesResponse> getAllFav(String userToken) async {
    final ans = await _dio.get(ApiConstant.getAllFavorite,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));
    return GetServicesResponse.fromJson(ans.data);
  }
}
