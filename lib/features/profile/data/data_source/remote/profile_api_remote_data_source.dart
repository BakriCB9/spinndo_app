import 'dart:io';

import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/client_update/update_client_response.dart';
import 'package:app/features/profile/data/models/delete_image/delete_image.dart';
import 'package:app/features/profile/data/models/image_profile_photo/image_profile_response.dart';
import 'package:app/features/profile/data/models/provider_modle/provider_profile_modle.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_response.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_request.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_response.dart';
import 'package:app/main.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:app/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileApiRemoteDataSource implements ProfileRemoteDataSource {
  final Dio _dio;
  SharedPreferences _sharedPreferences;

  ProfileApiRemoteDataSource(this._dio, this._sharedPreferences);

  @override
  Future<ClientProfileRespoonse> getClientProfile(
      int user_id, String user_token) async {
    final response = await _dio.get(
        '${ApiConstant.profilCelientEndPotint}/$user_id',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $user_token"
        }));

    return ClientProfileRespoonse.fromJson(response.data);

    // try {
    //   // final String userToken = _authLocalDataSource.getToken();
    //   // final int user_id = _authLocalDataSource.getUserId();

    // } catch (exciption) {
    //   throw RemoteAppException("Failed to get client");
    // }
  }

  @override
  Future<ProviderProfileResponse> getServiceProviderProfile(
      int user_id, String user_token) async {
    final lang = _sharedPreferences.getString('language');
    final response =
        await _dio.get('${ApiConstant.profileServiceProviderEndPoint}/$user_id',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $user_token",
            }));

    return ProviderProfileResponse.fromJson(response.data);

    // try {
    //   // final String userToken = _authLocalDataSource.getToken();
    //   // final int user_id = _authLocalDataSource.getUserId();
    //   // var userRole=_authLocalDataSource.getUserRole();
    //   // print('the token is from api is ${user_token}');
    //   // print('the user id is now ${user_id}');

    // } catch (exciption) {
    //   throw RemoteAppException("Failed to get client");
    // }
  }

  @override
  Future<UpdateClientResponse> updateClientProfile(
      UpdateAccountProfile updateRequest) async {
    final userToken = sharedPref.getString(CacheConstant.tokenKey);
    final response = await _dio.post(ApiConstant.updateClientProfile,
        data: updateRequest.toJson(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }));

    return UpdateClientResponse.fromJson(response.data);
    // try {

    // } catch (e) {
    //   throw RemoteAppException('Failed to update info');
    // }
  }

  @override
  Future<UpdateProviderResponse> updateProviderProfile(
      UpdateProviderRequest updateRequest, int typeEdit) async {
    
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

    // try {

    // } catch (e) {
    //   throw RemoteAppException('Failed to Update info');
    // }
  }

  @override
  Future<ImageProfileResponse> addImagePhoto(File image) async {
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

    return ImageProfileResponse.fromJson(response.data);
    // try {

    // } catch (e) {
    //   throw RemoteAppException('Failed to add Image');
    // }
  }

  @override
  Future<DeleteImageResponse> deleteImage() async {
    final userToken = sharedPref.getString(CacheConstant.tokenKey);
    final response = await _dio.post(ApiConstant.deleteImage,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }),
        data: {'for_delete': '1'});
    return DeleteImageResponse.fromJson(response.data);

    // try {

    // } catch (e) {
    //   throw RemoteAppException('Failed to delete image,try again');
    // }
  }

  @override
  Future<SocialMediaLinksResponse> addOrupdateLinkSocial(
      SocialMediaLinksRequest socialMediaLinksRequest) async {
    final userToken = sharedPref.getString(CacheConstant.tokenKey);
    final userid = sharedPref.getInt(CacheConstant.userId);

    final response = await _dio.post(
        '${ApiConstant.addOrupdateLinkSocial}/$userid',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        }),
        data: socialMediaLinksRequest.toJson());
    return SocialMediaLinksResponse.fromJson(response.data);
    // try {

    // } catch (e) {
    //   throw RemoteAppException('Failed to add link of social');
    // }
  }

  @override
  Future<String> deleteSocialLinks(int idOfSocial) async {
    final userToken = sharedPref.getString(CacheConstant.tokenKey);

    final response = await _dio.delete(
      '${ApiConstant.deleteSocialLinks}/$idOfSocial',
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken"
      }),
    );
    return response.data["message"];
    // try {

    // } catch (e) {
    //   throw RemoteAppException('Failed to add link of social');
    // }
  }
}
