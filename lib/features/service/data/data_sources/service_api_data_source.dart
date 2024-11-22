import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:snipp/core/constant.dart';
import 'package:snipp/core/error/app_exception.dart';
import 'package:snipp/features/service/data/models/get_all_category_response/get_all_category_response.dart';
import 'package:snipp/features/service/data/models/get_all_countries_response/get_all_countries_response.dart';
import 'package:snipp/features/service/data/models/get_services_request.dart';
import 'package:snipp/features/service/data/models/get_services_response/get_services_response.dart';

import 'service_data_source.dart';

@Singleton(as: ServiceDataSource)
class ServiceApiDataSource implements ServiceDataSource {
  final Dio _dio;

  ServiceApiDataSource( this._dio);
  Future<GetServicesResponse> getServices(GetServicesRequest requestBody) async {
    try {

      final response = await _dio.get(data:requestBody.toJson() ,
          ApiConstant.getServices,
         );

      return GetServicesResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get services");
    }
  }

  @override
  Future<GetAllCategoryResponse> getAllCategory()async {
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
  Future<GetAllCountriesResponse> getAllCountries()async {
    try {

      final response = await _dio.get(
        ApiConstant.getAllCountries,
      );

      return GetAllCountriesResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get countries");
    }
  }

  @override
  Future<void> getAllCountriesAndCategories() async {
await getAllCountries();
await getAllCategory();
  }



}
