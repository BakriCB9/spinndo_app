import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';
import 'package:app/features/packages/data/model/subscription/unsubscribe_response.dart'; // Add the unsubscribe model
import '../../../../core/error/apiResult.dart';

abstract class PackageRepository {
  Future<ApiResult<List<PackageModel>>> getAllPackages();
  Future<ApiResult<SubscribeResponse>> addSubscribe(SubscribeModel subscribe);
  Future<ApiResult<UnSubscribeResponse>> addUnsubscribe(int userId);
}
