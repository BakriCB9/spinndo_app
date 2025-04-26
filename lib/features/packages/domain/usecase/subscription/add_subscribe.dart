import 'package:app/core/error/apiResult.dart';
import 'package:app/features/favorite/domain/repositry/fav_repositry.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';
import 'package:app/features/packages/domain/repositry/package_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddSubscribeUseCase {
  PackageRepository subscribeRepositry;
  AddSubscribeUseCase(this.subscribeRepositry);
  Future<ApiResult<SubscribeResponse?>> call(SubscribeModel subscribe) =>
      subscribeRepositry.addSubscribe(subscribe);
}
