import 'dart:convert';
import 'dart:io';

import 'package:app/core/constant.dart';
import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/client_update/update_client_response.dart';
import 'package:app/features/profile/data/models/delete_image/delete_image.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
import 'package:app/features/profile/data/models/provider_modle/data.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_request.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_response.dart';
import 'package:app/features/profile/domain/entities/add_or_update_soical_entity/add_or_update_social_entity.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';

import 'package:app/main.dart';
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
//       import 'dart:io';
// import 'dart:typed_data';
// import 'package:path_provider/path_provider.dart';

      /// Save Uint8List to a file in the app's local directory.

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/bb';
      final file = File(filePath);
      final ans = await file.writeAsBytes(bytes, flush: true);
      await sharedPref.setString('imageFile', ans.path);

      // return filePath;
      return Right(response);
    } on AppException catch (exception) {
      return left(Failure(exception.message));
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
      // print('we are in response now bakkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk  ${response}');
      return Right(response.data!);
    } on AppException catch (exception) {
      // print('we failed bakkkkkkkkkkkkaer we are sorrryyyyyyyy error ${exception.message}');

      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, DeleteImageResponse>> deleteImage() async {
    try {
      final response = await _profileRemoteDataSource.deleteImage();

      sharedPref.remove(CacheConstant.imagePhotoFromLogin);
      sharedPref.remove(CacheConstant.imagePhoto);
      sharedPref.remove('imageFile');
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

   @override
     Future<Either<Failure, AddOrUpdateSocialEntity>> addOrupdateLinkSocial(
      SocialMediaLinksRequest socialMediaLinksRequest) async {
    try {
      final response = await _profileRemoteDataSource
          .addOrupdateLinkSocial(socialMediaLinksRequest);

      return Right(response.data!.toAddOrUpdateSocialEntity());
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

     Future<Either<Failure, String>> deleteSocialLinks(int idOfSocial)async{
           try {
      final response = await _profileRemoteDataSource
          .deleteSocialLinks(idOfSocial);

      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
     }
}
