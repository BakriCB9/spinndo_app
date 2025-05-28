import 'dart:io';
import 'package:app/core/constant.dart';
import 'package:app/core/network/remote/handle_dio_exception.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/client_update/update_client_response.dart';
import 'package:app/features/profile/data/models/delete_image/delete_image.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';

import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_request.dart';

import 'package:app/features/profile/domain/entities/add_or_update_soical_entity/add_or_update_social_entity.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/features/profile/data/data_source/local/profile_local_data_source.dart';
import 'package:app/features/profile/data/data_source/remote/profile_remote_data_source.dart';

import 'package:app/features/profile/domain/entities/client_profile.dart';
import 'package:app/features/profile/domain/repository/profile_repository.dart';
import 'package:path_provider/path_provider.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final ProfileLocalDataSource _profileLocalDataSource;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  ProfileRepositoryImpl(this._sharedPreferencesUtils,
      this._profileRemoteDataSource, this._profileLocalDataSource);

  @override
  Future<Either<Failure, ClientProfile>> getClient() async {
    try {
      final user_id = _profileLocalDataSource.getUserId();
      final user_token = _profileLocalDataSource.getToken();
      final clientResponse =
          await _profileRemoteDataSource.getClientProfile(user_id, user_token);
      return Right(clientResponse.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  @override
  Either<Failure, String> getUserRole() {
    try {
      final response = _profileLocalDataSource.getUserRole();
      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, UpdateClientResponse>> updateClientProfile(
      UpdateAccountProfile updateRequest) async {
    try {
      final response =
          await _profileRemoteDataSource.updateClientProfile(updateRequest);
      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, UpdateProviderResponse>> updateProviderProfile(
      UpdateProviderRequest updateRequest, int typeEdit) async {
    try {
      print(
          'the id of of user is $typeEdit and data is ${updateRequest.nameService} and descrp ${updateRequest.descriptionService} and web site is  ${updateRequest.websiteService} and category ${updateRequest.categoryIdService} and city ${updateRequest.cityNameService}');
      final response = await _profileRemoteDataSource.updateProviderProfile(
          updateRequest, typeEdit);

      return Right(response);
    } catch (e) {
      print('');
      print('the eception is $e');
      print('');
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, ImageProfileResponse>> addImageProfile(
      File iamge) async {
    try {
      final response = await _profileRemoteDataSource.addImagePhoto(iamge);
      // Convert the image to bytes
      final bytes = await iamge.readAsBytes();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/bb';
      final file = File(filePath);
      final ans = await file.writeAsBytes(bytes, flush: true);
      await _sharedPreferencesUtils.saveData(
          key: CacheConstant.imagePhotoFromFile, value: ans.path);
      _sharedPreferencesUtils.removeData(key: CacheConstant.imagePhoto);
      // return filePath;
      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, ProviderProfile>> getServiceProvider() async {
    try {
      // print('we start now');
      final user_id = _profileLocalDataSource.getUserId();
      final user_token = _profileLocalDataSource.getToken();
      final response = await _profileRemoteDataSource.getServiceProviderProfile(
          user_id, user_token);

      return Right(response.data!);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, DeleteImageResponse>> deleteImage() async {
    try {
      final response = await _profileRemoteDataSource.deleteImage();

      _sharedPreferencesUtils.removeData(key: CacheConstant.imagePhoto);
      _sharedPreferencesUtils.removeData(key: CacheConstant.imagePhotoFromFile);

      // sharedPref.remove('imageFile');
      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, AddOrUpdateSocialEntity>> addOrupdateLinkSocial(
      SocialMediaLinksRequest socialMediaLinksRequest) async {
    try {
      final response = await _profileRemoteDataSource
          .addOrupdateLinkSocial(socialMediaLinksRequest);

      return Right(response.data!.toAddOrUpdateSocialEntity());
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }

  @override
  Future<Either<Failure, String>> deleteSocialLinks(int idOfSocial) async {
    try {
      final response =
          await _profileRemoteDataSource.deleteSocialLinks(idOfSocial);

      return Right(response);
    } catch (e) {
      final exception = HandleException.exceptionType(e);
      return Left(Failure(exception));
    }
  }
}
