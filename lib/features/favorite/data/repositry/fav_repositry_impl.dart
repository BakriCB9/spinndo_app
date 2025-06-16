import 'package:app/core/constant.dart';
import 'package:app/core/error/apiResult.dart';
import 'package:app/features/favorite/data/dataSource/remote/remote_datasource.dart';
import 'package:app/features/favorite/domain/repositry/fav_repositry.dart';
import 'package:app/features/service/data/models/get_services_response/data.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: FavRepositry)
class FavRepositryImpl extends FavRepositry {
  RemoteDatasource remoteDatasource;
  SharedPreferences sharedPreferences;
  FavRepositryImpl(this.remoteDatasource, this.sharedPreferences);
  @override
  Future<ApiResult<String?>> addToFav(String userId) async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);

      final ans = await remoteDatasource.addToFav(userId, userToken!);
      return ApiResultSuccess<String?>(ans);
    } catch (e) {
      return ApiresultError<String?>(e.toString());
    }
  }

  @override
  Future<ApiResult<String?>> removeFromFav(String id) async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      final ans = await remoteDatasource.removeFromFav(id, userToken!);
      return ApiResultSuccess<String?>(ans);
    } catch (e) {
      return ApiresultError<String?>(e.toString());
    }
  }

  @override
  Future<ApiResult<List<Data?>>> getAllFav(double latitude, double longitude) async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      final ans = await remoteDatasource.getAllFav(userToken!, latitude,  longitude);
      print('');
      print('the value of favorite in respositry is ${ans.data}');
      print('');
      return ApiResultSuccess<List<Data?>>(ans.data ?? []);
    } catch (e) {
      return ApiresultError<List<Data?>>('Failed to get Favorite items');
    }
  }
}
