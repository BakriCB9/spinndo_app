import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/features/profile/data/data_source/remote/profile_remote_data_source.dart';
import 'package:snipp/features/profile/data/models/client_profile_respoonse/client_profile_respoonse.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileApiRemoteDataSource extends ProfileRemoteDataSource {
  final Dio _dio;

  ProfileApiRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<ClientProfileRespoonse> getClientProfile() async {
    try {
      final response = await _dio.get(ApiConstant.profilCelientEndPotint);
      return ClientProfileRespoonse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get client");
    }
  }

  @override
  Future<ClientProfileRespoonse> getServiceProviderProfile() {
    // TODO: implement getServiceProviderProfile
    throw UnimplementedError();
  }

//   @override
//   Future<ClientProfileRespoonse> getServiceProviderProfile()async {
// return
//   }
}
