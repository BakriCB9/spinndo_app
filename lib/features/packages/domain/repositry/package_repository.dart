import 'package:app/features/packages/data/model/package_model.dart';
import '../../../../core/error/apiResult.dart';


abstract class PackageRepository {
  Future<ApiResult<List<PackageModel>>> getAllPackages();
}