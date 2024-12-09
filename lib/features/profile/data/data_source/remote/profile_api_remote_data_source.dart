import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/error/app_exception.dart';
import 'package:app/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:app/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:app/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';
import 'package:app/features/profile/data/models/provider_model/provider_profile_model.dart';

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
}
