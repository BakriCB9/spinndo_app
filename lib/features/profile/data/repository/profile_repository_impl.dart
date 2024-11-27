import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/data/data_source/local/profile_local_data_source.dart';
import 'package:snipp/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:snipp/features/profile/data/models/provider_model/data.dart';

import 'package:snipp/features/profile/domain/entities/client_profile.dart';
import 'package:snipp/features/profile/domain/repository/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ProfileLocalDataSource _profileLocalDataSource;

  ProfileRepositoryImpl(
      this._profileRemoteDataSource, this._profileLocalDataSource);

  @override
  Future<Either<Failure, ClientProfile>> getClient() async {
    try {
      final user_id = _profileLocalDataSource.getUserId();
      final user_token = _profileLocalDataSource.getToken();
      final clientResponse =
          await _profileRemoteDataSource.getClientProfile(user_id, user_token);
      return Right(clientResponse.data!);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, Data>> getServiceProvider() async {
    try {
      // print('we start now');
      final user_id = _profileLocalDataSource.getUserId();
      final user_token = _profileLocalDataSource.getToken();
      final response = await _profileRemoteDataSource.getServiceProviderProfile(
          user_id, user_token);
      // print('we are in response now bakkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk  ${response}');
      return Right(response.data!);
    } on AppException catch (exception) {
      // print('we failed bakkkkkkkkkkkkaer we are sorrryyyyyyyy error ${exception.message}');

      return Left(Failure(exception.message));
    }
  }

  @override
  Either<Failure, String> getUserRole() {
    try {
      final response = _profileLocalDataSource.getUserRole();
      return Right(response);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }
}
