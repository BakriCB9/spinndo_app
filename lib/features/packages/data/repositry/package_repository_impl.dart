import 'package:app/core/constant.dart';
import 'package:app/core/error/apiResult.dart';
import 'package:app/features/packages/data/data_source/remote/packages_remote_datasource.dart';
import 'package:app/features/packages/data/model/package_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_model.dart';
import 'package:app/features/packages/data/model/subscription/subscribe_response.dart';
import 'package:app/features/packages/data/model/subscription/unsubscribe_response.dart';
import 'package:app/features/packages/domain/repositry/package_repository.dart';
import 'package:app/features/profile/data/data_source/local/profile_local_data_source.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: PackageRepository)
class PackageRepositoryImpl extends PackageRepository {
  final PackagesRemoteDataSource packagesRemoteDataSource;
  final SharedPreferences sharedPreferences;
  final ProfileLocalDataSource _profileLocalDataSource;

  PackageRepositoryImpl(this.packagesRemoteDataSource, this.sharedPreferences, this._profileLocalDataSource);

  @override
  Future<ApiResult<List<PackageModel>>> getAllPackages() async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      if (userToken == null) {
        return ApiresultError<List<PackageModel>>("User token is missing");
      }

      final packages = await packagesRemoteDataSource.getAllPackages(userToken);
      print('\nFetched packages: $packages\n');

      return ApiResultSuccess<List<PackageModel>>(packages);
    } catch (e) {
      print('Error while fetching packages: $e');
      return ApiresultError<List<PackageModel>>('Failed to get packages');
    }
  }

  @override
  Future<ApiResult<SubscribeResponse>> addSubscribe(SubscribeModel subscribe) async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      if (userToken == null) {
        return ApiresultError<SubscribeResponse>("User token is missing");
      }

      final response = await packagesRemoteDataSource.subscribe(subscribe, userToken);

      if (response == null) {
        return ApiresultError<SubscribeResponse>('Subscription failed: No response data');
      }

      print("TOKEN is: $userToken");
      print('Subscription successfully added');

      return ApiResultSuccess<SubscribeResponse>(response);
    } catch (exception) {
      print('Error occurred: $exception');
      var message = 'Failed to add subscription';

      if (exception is DioException) {
        print('DioException occurred: $exception');

        if (exception.type == DioExceptionType.badResponse) {
          message = 'Server error';
        } else {
          final errorMessage = exception.response?.data['message'];
          if (errorMessage != null) message = errorMessage;
        }
      }

      return ApiresultError<SubscribeResponse>(message);
    }
  }

  @override
  Future<ApiResult<UnSubscribeResponse>> addUnsubscribe(int userId) async {
    try {
      final userToken = sharedPreferences.getString(CacheConstant.tokenKey);
      if (userToken == null) {
        return ApiresultError<UnSubscribeResponse>("User token is missing");
      }

      final response = await packagesRemoteDataSource.unsubscribe(userId, userToken);

      if (response == null) {
        return ApiresultError<UnSubscribeResponse>('Unsubscription failed: No response data');
      }

      print("TOKEN is: $userToken");
      print('Unsubscription successfully added');

      return ApiResultSuccess<UnSubscribeResponse>(response);
    } catch (exception) {
      print('Error occurred: $exception');
      var message = 'Failed to add unsubscription';

      if (exception is DioException) {
        print('DioException occurred: $exception');

        if (exception.type == DioExceptionType.badResponse) {
          message = 'Server error';
        } else {
          final errorMessage = exception.response?.data['message'];
          if (errorMessage != null) message = errorMessage;
        }
      }

      return ApiresultError<UnSubscribeResponse>(message);
    }
  }



}
