import 'package:app/features/profile/data/models/provider_modle/provider_profile_modle.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/error/app_exception.dart';

import 'package:app/features/service/data/models/get_all_category_response/get_all_category_response.dart';
import 'package:app/features/service/data/models/get_all_countries_response/get_all_countries_response.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/data/models/get_services_response/get_services_response.dart';

import 'service_data_source.dart';

@LazySingleton(as: ServiceDataSource)
class ServiceApiDataSource implements ServiceDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  ServiceApiDataSource(this._dio, this._sharedPreferences);

  Future<GetServicesResponse> getServices(
      GetServicesRequest requestBody) async {
    try {
      // final response = await _dio.get(
      //   // data: requestBody.toJson(),
      //   ApiConstant.getServices,
      // );
      final response = await _dio.request(
        ApiConstant.getServices,
        data: requestBody.toJson(), // Include the body here
        options: Options(
          method: 'GET', // Specify GET explicitly
          headers: {
            'Content-Type':
                'application/json', // Optional: Set headers if needed
          },
        ),
      );

      return GetServicesResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get services");
    }
  }

  @override
  Future<GetAllCategoryResponse> getAllCategory() async {
    try {
      final response = await _dio.get(
        ApiConstant.getAllCategory,
      );

      return GetAllCategoryResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get categories");
    }
  }

  @override
  Future<GetAllCountriesResponse> getAllCountries() async {
    try {
      final response = await _dio.get(
        ApiConstant.getAllCountries,
      );

      return GetAllCountriesResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get countries");
    }
  }

  Future<ProviderProfileResponse> getProviderService(int id) async {
    try {
      String user_token = _sharedPreferences.getString(CacheConstant.tokenKey)!;
      final response = await _dio.get(
          '${ApiConstant.profileServiceProviderEndPoint}/$id',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $user_token"
          }));

      return ProviderProfileResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get Details");
    }
  }
}
