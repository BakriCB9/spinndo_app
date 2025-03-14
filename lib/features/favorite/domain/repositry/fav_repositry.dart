import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service/data/models/get_services_response/data.dart';

abstract class FavRepositry {
  Future<ApiResult<String?>> addToFav(String userId);
  Future<ApiResult<String?>> removeFromFav(String userId);
  Future<ApiResult<List<Data?>>> getAllFav();
}
