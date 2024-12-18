import 'dart:convert';
import 'dart:io';

import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/client_update/update_client_response.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/data_source/local/profile_local_data_source.dart';
import 'package:app/features/profile/data/data_source/remote/profile_remote_data_source.dart';

import 'package:app/features/profile/domain/entities/client_profile.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';

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


  @override
  Either<Failure, String> getUserRole() {
    try {
      final response = _profileLocalDataSource.getUserRole();
      return Right(response);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, UpdateClientResponse>> updateClientProfile(
      UpdateAccountProfile updateRequest) async {
    try {
      final response =
          await _profileRemoteDataSource.updateClientProfile(updateRequest);
      return Right(response);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  Future<Either<Failure, UpdateProviderResponse>> updateProviderProfile(
      UpdateProviderRequest updateRequest, int typeEdit) async {
    try {
      final response = await _profileRemoteDataSource.updateProviderProfile(
          updateRequest, typeEdit);
      return Right(response);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, ImageProfileResponse>> addImageProfile(
      File iamge) async {
    try {
      final response = await _profileRemoteDataSource.addImagePhoto(iamge);
      // Convert the image to bytes
      final bytes = await iamge.readAsBytes();

      // Convert bytes to Base64 string
      final base64String = base64Encode(bytes);
      await _profileLocalDataSource.imagePhoto(base64String);

      return Right(response);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, ProviderProfile>> getServiceProvider() {
    // TODO: implement getServiceProvider
    throw UnimplementedError();
  }

}
