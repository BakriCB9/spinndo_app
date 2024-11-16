import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/core/error/failure.dart';
import 'package:snipp/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:snipp/features/profile/data/models/provider_model/data.dart';

import 'package:snipp/features/profile/domain/entities/client.dart';
import 'package:snipp/features/profile/domain/repository/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, Client>> getClient() async {
    try {
      final clientResponse = await _remoteDataSource.getClientProfile();
      return Right(clientResponse.data!);
    } on RemoteAppException catch (exception) {
      return left(RemotFailure(exception.message));
    }
  }

  @override
  Future<Either<Failure, Data>> getServiceProvider() async {
    try {
      print('we start now');
      final response = await _remoteDataSource.getServiceProviderProfile();
      print('we are in response now bakkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk  ${response}');
      return Right(response.data!);
    } on RemoteAppException catch (exception) {
      print('we failed bakkkkkkkkkkkkaer we are sorrryyyyyyyy error ${exception.message}');
    
      return Left(RemotFailure(exception.message));
    }
  }
}