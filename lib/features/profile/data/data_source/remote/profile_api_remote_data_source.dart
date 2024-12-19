import 'dart:io';

import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/client_update/update_client_response.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
import 'package:app/features/profile/data/models/provider_modle/provider_profile_modle.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:app/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:app/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileApiRemoteDataSource implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileApiRemoteDataSource(this._dio);

  @override
  Future<ClientProfileRespoonse> getClientProfile(
      int user_id, String user_token) async {
    try {
      // final String userToken = _authLocalDataSource.getToken();
      // final int user_id = _authLocalDataSource.getUserId();

      final response = await _dio.get(
          '${ApiConstant.profilCelientEndPotint}/$user_id',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $user_token"
          }));

      return ClientProfileRespoonse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get client");
    }
  }

  @override
  Future<ProviderProfileResponse> getServiceProviderProfile(
      int user_id, String user_token) async {
    try {
      // final String userToken = _authLocalDataSource.getToken();
      // final int user_id = _authLocalDataSource.getUserId();
      // var userRole=_authLocalDataSource.getUserRole();
      // print('the token is from api is ${user_token}');
      // print('the user id is now ${user_id}');

      final response = await _dio.get(
          '${ApiConstant.profileServiceProviderEndPoint}/$user_id',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $user_token"
          }));
      // print(
      //     'th eresponse is WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWwQQQQQQQQQQQQQQ ${response.data}');
      //

      return ProviderProfileResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get client");
    }
  }

  @override
  Future<UpdateClientResponse> updateClientProfile(
      UpdateAccountProfile updateRequest) async {
    try {
      final userToken = sharedPref.getString(CacheConstant.tokenKey);
      final response = await _dio.post(ApiConstant.updateClientProfile,
          data: updateRequest.toJson(),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));
      print('ther token is for update profile client  $userToken');
      return UpdateClientResponse.fromJson(response.data);
    } catch (e) {
      throw RemoteAppException('Failed to update info');
    }
  }

  @override
  Future<UpdateProviderResponse> updateProviderProfile(
      UpdateProviderRequest updateRequest, int typeEdit) async {
    try {
      final userToken = sharedPref.getString(CacheConstant.tokenKey);
      final response = await _dio.post(ApiConstant.updateProviderProfile,
          data: typeEdit == 1
              ? updateRequest.toJsonAccount()
              : (typeEdit == 2
                  ? updateRequest.toJsonJobDetails()
                  : (updateRequest.toJsonDateTime())),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));

      return UpdateProviderResponse.fromJson(response.data);
    } catch (e) {
      throw RemoteAppException('Failed to Update info');
    }
  }

  @override
  Future<ImageProfileResponse> addImagePhoto(File image) async {
    try {
      final imagePhoto = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
      final userToken = sharedPref.getString(CacheConstant.tokenKey);
      final response = await _dio.post(ApiConstant.imageProfile,
          data: FormData.fromMap({'image': imagePhoto}),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));

      print(
          'we Do it  now yessssssssssssssssssssssssssssssssssssssssssssssssss yesssssssssssssss');
      return ImageProfileResponse.fromJson(response.data);
    } catch (e) {
      throw RemoteAppException('Failed to add Image');
    }
  }
}
