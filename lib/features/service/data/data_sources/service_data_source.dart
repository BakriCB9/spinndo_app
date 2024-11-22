
import 'package:snipp/features/service/data/models/get_all_category_response/get_all_category_response.dart';
import 'package:snipp/features/service/data/models/get_all_countries_response/get_all_countries_response.dart';
import 'package:snipp/features/service/data/models/get_services_request.dart';
import 'package:snipp/features/service/data/models/get_services_response/get_services_response.dart';

abstract class ServiceDataSource {
  Future<GetServicesResponse> getServices(GetServicesRequest requestBody);
  Future<GetAllCategoryResponse> getAllCategory();
  Future<GetAllCountriesResponse> getAllCountries();
  Future<void> getAllCountriesAndCategories();

}
