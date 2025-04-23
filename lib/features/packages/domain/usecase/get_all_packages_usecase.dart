import 'package:app/features/packages/data/model/package_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/apiResult.dart';
import '../repositry/package_repository.dart';

@lazySingleton
class GetAllPackagesUseCase {
   PackageRepository repository;
   GetAllPackagesUseCase(this.repository);
   Future<ApiResult<List<PackageModel>>> call() async {
     ApiResult<List<PackageModel>> ans = await repository.getAllPackages();
     return ans;
   }
}


