import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:snipp/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:snipp/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';
import 'package:snipp/features/profile/data/models/provider_model/provider_model.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileApiRemoteDataSource extends ProfileRemoteDataSource {
  final Dio _dio;
  final AuthLocalDataSource _authLocalDataSource;

  ProfileApiRemoteDataSource(this._dio, this._authLocalDataSource);

  @override
  Future<ClientProfileRespoonse> getClientProfile() async {
    try {
      final String userToken = _authLocalDataSource.getToken();
      final int user_id = _authLocalDataSource.getUserId();

      final response = await _dio.get(
          '${ApiConstant.profilCelientEndPotint}/$user_id',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));

      return ClientProfileRespoonse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get client");
    }
  }

  @override
  Future<ProviderResponse> getServiceProviderProfile() async {
    try {
      final String userToken = _authLocalDataSource.getToken();
      final int user_id = _authLocalDataSource.getUserId();
      var userRole=_authLocalDataSource.getUserRole();
      print('the token is from api is ${userToken}');
      print('the user id is now ${user_id}');

      final response = await _dio.get(
          '${ApiConstant.profileServiceProviderEndPoint}/$user_id',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));
      print(
          'th eresponse is WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWwQQQQQQQQQQQQQQ ${response.data}');


      return ProviderResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get client");
    }
  }

//   @override
//   Future<ClientProfileRespoonse> getServiceProviderProfile()async {
// return
//   }
}
