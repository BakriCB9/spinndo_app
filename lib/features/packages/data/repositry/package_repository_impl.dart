import 'package:app/core/constant.dart';
import 'package:app/core/error/apiResult.dart';
import 'package:app/features/service/data/models/get_services_response/data.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../service/data/models/get_package_reponse/get_package_reponse.dart';
import '../../domain/repositry/package_repository.dart';
import '../dataSource/remote/packages_remote_datasource.dart';

@Injectable(as: PackageRepository)
class PackageRepositoryImpl extends PackageRepository {
  late PackagesRemoteDataSource packagesRemoteDataSource;
  late SharedPreferences sharedPreferences;
  PackageRepositoryImpl(this.packagesRemoteDataSource, this.sharedPreferences);

  @override
  Future<ApiResult<List<PackageData>>> getAllPackages() async {
      try {
        final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
        final ans = await packagesRemoteDataSource.getAllPackages(userToken!);
        print('');
        print('the value of package in respositry is ${ans.data}');
        print('');
        return ApiResultSuccess<List<PackageData>>(ans.data);
      } catch (e) {
        return ApiresultError<List<PackageData>>('Failed to get Favorite items');
      }
  }
}