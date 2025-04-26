import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';
import 'package:app/features/packages/data/model/subscription/unsubscribe_response.dart';

import '../../model/package_model.dart';
import '../../model/subscription/subscribe_model.dart';

abstract class PackagesRemoteDataSource {
  Future<List<PackageModel>> getAllPackages(String userToken);
  Future<SubscribeResponse?> subscribe (SubscribeModel subscribe,String userToken);
  Future<UnSubscribeResponse?> unsubscribe(int userId, String userToken);

}
