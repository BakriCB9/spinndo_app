import 'package:app/features/profile/data/models/provider_modle/provider_profile_modle.dart';
import 'package:app/features/service/data/models/get_category_main/get_category_main.dart';
import 'package:app/features/service/data/models/notification/notification_model/notification_model.dart';
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

@Injectable(as: ServiceDataSource)
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
      final lang = _sharedPreferences.getString('language');
      final response = await _dio.request(
        ApiConstant.getServices,
        data: requestBody.toJson(), // Include the body here
        options: Options(
          method: 'GET', // Specify GET explicitly
          headers: {
            "Accept-Language": '$lang',
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
      final lang = _sharedPreferences.getString('language');
      final response = await _dio.get(ApiConstant.getAllCategory,
          options: Options(
            headers: {
              "Accept-Language": '$lang',
              'Content-Type':
                  'application/json', // Optional: Set headers if needed
            },
          ));

      return GetAllCategoryResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get categories");
    }
  }

  @override
  Future<GetAllCountriesResponse> getAllCountries() async {
    try {
      final lang = _sharedPreferences.getString('language');
      final response = await _dio.get(ApiConstant.getAllCountries,
          options: Options(
            headers: {
              "Accept-Language": '$lang',
              'Content-Type':
                  'application/json', // Optional: Set headers if needed
            },
          ));

      return GetAllCountriesResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get countries");
    }
  }

  Future<ProviderProfileResponse> getProviderService(int id) async {
    try {
      final lang = _sharedPreferences.getString('language');
      String user_token = _sharedPreferences.getString(CacheConstant.tokenKey)!;
      final response =
          await _dio.get('${ApiConstant.profileServiceProviderEndPoint}/$id',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $user_token",
                "Accept-Language": '$lang',
              }));

      return ProviderProfileResponse.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get Details");
    }
  }

  @override
  Future<NotificationModel> getAllNotification() async {
    try {
      final lang = _sharedPreferences.getString('language');
      String user_token = _sharedPreferences.getString(CacheConstant.tokenKey)!;
      final response = await _dio.get(ApiConstant.getAllNotification,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $user_token",
            "Accept-Language": '$lang',
          }));

      return NotificationModel.fromJson(response.data);
    } catch (exciption) {
      throw RemoteAppException("Failed to get Notification");
    }
  }

  @override
  Future<GetCategoryMain> getAllMainCategory() async{
    
    // final ans=await  _dio.get(ApiConstant.getAllMainCategory);
   try {
      //final lang = _sharedPreferences.getString('language');
      //String user_token = _sharedPreferences.getString(CacheConstant.tokenKey)!;
      final response = await _dio.get(ApiConstant.getAllMainCategory,
          // options: Options(headers: {
          //   "Content-Type": "application/json",
          //   "Authorization": "Bearer $user_token",
          //   "Accept-Language": '$lang',
          // })
          
          );

      return GetCategoryMain.fromJson(response.data); 
    } catch (exciption) {
      throw RemoteAppException("Failed to get data");
    }
  }


  }


