import 'package:app/features/service/data/models/get_package_reponse/data.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/apiResult.dart';
import '../repositry/package_repository.dart';

@lazySingleton
class GetAllPackagesUseCase {
   PackageRepository repository;
   GetAllPackagesUseCase(this.repository);
   Future<ApiResult<List<PackagesData?>>> call() async {
     ApiResult<List<PackagesData?>> ans = await repository.getAllPackages();
     return ans;
   }
}


