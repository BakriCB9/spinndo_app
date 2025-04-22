import 'package:app/features/service/data/models/get_package_reponse/data.dart';
import '../../../../core/error/apiResult.dart';


abstract class PackageRepository {
  Future<ApiResult<List<PackagesData?>>> getAllPackages();
}