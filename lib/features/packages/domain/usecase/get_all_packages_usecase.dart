import 'package:injectable/injectable.dart';

import '../../../../core/error/apiResult.dart';
import '../../../auth/data/models/category_response/datum.dart';
import '../../../service/data/models/get_package_reponse/get_package_reponse.dart';
import '../package_intity.dart';
import '../repositry/package_repository.dart';

@lazySingleton
class GetAllPackagesUseCase {
   PackageRepository repository;
   GetAllPackagesUseCase(this.repository);
   Future<ApiResult<List<PackageData>>> call() async {
     ApiResult<List<PackageData>> ans = await repository.getAllPackages();
     return ans;
   }
}