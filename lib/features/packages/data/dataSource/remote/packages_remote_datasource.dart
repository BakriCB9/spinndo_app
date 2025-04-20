
import '../../../../service/data/models/get_package_reponse/get_package_reponse.dart';

abstract class PackagesRemoteDataSource {
  Future<GetPackagesResponse> getAllPackages(String userToken);
}
