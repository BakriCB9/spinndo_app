import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      //final String userToken = _authLocalDataSource.getToken();
      //final int user_id = _authLocalDataSource.getUserId();
      final user_id = 44;
      final String userToken =
          "31|kwc6MUsBVaX4GZreOzzqtIcJqkJ4c09DwJ7OgNOA01365e31";
      final response = await _dio.get(
          '${ApiConstant.profilCelientEndPotint}/$user_id',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));
      print("the result from api is ${response.data}");
      return ClientProfileRespoonse.fromJson(response.data);
    } catch (exciption) {
      print('we threom exception now there are som error');
      throw RemoteAppException("Failed to get client");
    }
  }

  @override
  Future<ProviderResponse> getServiceProviderProfile() async {
    try {
      final String userToken = _authLocalDataSource.getToken();
      final int user_id = _authLocalDataSource.getUserId();
     // final user_id = 5;
      //final String userToken =
         // "3|ZrU3kyulNnnfrN1YdrO8VbadnZ8cwq2WOfxtfKM0ecb80aef";
      final response = await _dio.get(
          '${ApiConstant.profileServiceProviderEndPoint}/$user_id',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $userToken"
          }));

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
