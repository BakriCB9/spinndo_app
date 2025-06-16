import 'package:app/core/error/apiResult.dart';
import 'package:app/features/favorite/domain/repositry/fav_repositry.dart';
import 'package:app/features/service/data/models/get_services_response/data.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllFavUsecase {
  FavRepositry favRepositry;
  GetAllFavUsecase(this.favRepositry);
  Future<ApiResult<List<Data?>>> call(double latitude, double longitude) async {
    ApiResult<List<Data?>> ans = await favRepositry.getAllFav(latitude,longitude);

    return ans;
  }
}
