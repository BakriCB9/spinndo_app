import 'package:app/core/constant.dart';
import 'package:app/core/error/apiResult.dart';
import 'package:app/features/packages/data/data_source/remote/packages_remote_datasource.dart';
import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/packages/domain/repositry/package_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';


@Injectable(as: PackageRepository)
class PackageRepositoryImpl extends PackageRepository {
  late PackagesRemoteDataSource packagesRemoteDataSource;
  late SharedPreferences sharedPreferences;
  PackageRepositoryImpl(this.packagesRemoteDataSource, this.sharedPreferences);

  @override
  Future<ApiResult<List<PackageModel>>> getAllPackages() async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      final ans = await packagesRemoteDataSource.getAllPackages(userToken!);
      print('');
      print('the value of package in repository is $ans');
      print('');
      return ApiResultSuccess<List<PackageModel>>(ans);
    } catch (e) {
      return ApiresultError<List<PackageModel>>('Failed to get packages');
    }
  }
}