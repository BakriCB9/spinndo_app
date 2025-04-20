import '../../../../core/error/apiResult.dart';
import '../../../auth/data/models/category_response/datum.dart';
import '../../../service/data/models/get_package_reponse/get_package_reponse.dart';
import '../package_intity.dart';

abstract class PackageRepository {
  Future<ApiResult<List<PackageData>>> getAllPackages();
}