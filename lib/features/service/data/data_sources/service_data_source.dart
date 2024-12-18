import 'package:app/features/profile/data/models/provider_model/provider_profile_response.dart';
import 'package:app/features/service/data/models/get_all_category_response/get_all_category_response.dart';
import 'package:app/features/service/data/models/get_all_countries_response/get_all_countries_response.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/data/models/get_services_response/get_services_response.dart';

abstract class ServiceDataSource {
  Future<GetServicesResponse> getServices(GetServicesRequest requestBody);
  Future<GetAllCategoryResponse> getAllCategory();
  Future<GetAllCountriesResponse> getAllCountries();

  Future<ProviderProfileResponse> getProviderService(int id);
}
