import '../../model/package_model.dart';

abstract class PackagesRemoteDataSource {
  Future<List<PackageModel>> getAllPackages(String userToken);
}
