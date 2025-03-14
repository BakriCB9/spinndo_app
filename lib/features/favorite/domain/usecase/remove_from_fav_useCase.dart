import 'package:app/core/error/apiResult.dart';
import 'package:app/features/favorite/domain/repositry/fav_repositry.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFromFavUsecase {
  FavRepositry favRepositry;
  RemoveFromFavUsecase(this.favRepositry);
  Future<ApiResult<String?>> call(String userId) =>
      favRepositry.removeFromFav(userId);
}
