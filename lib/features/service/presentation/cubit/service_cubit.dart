import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:app/core/utils/map_helper/location_service.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/cities.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/use_cases/get_categories.dart';
import 'package:app/features/service/domain/use_cases/get_countries.dart';
import 'package:app/features/service/domain/use_cases/get_details.dart';
import 'package:app/features/service/domain/use_cases/get_services.dart';
import 'package:app/features/service/presentation/cubit/service_states.dart';

@singleton
class ServiceCubit extends Cubit<ServiceStates> {
  ServiceCubit(this._getServices, this._getCountries, this._getCategories,
      this._getServiceProfile)
      : super(ServiceInitial());
  final GetCountries _getCountries;
  final GetCategories _getCategories;
  final GetServices _getServices;
  final GetServiceProfile _getServiceProfile;
  List<Countries>? countriesList;
  List<Cities>? citiesList;
  List<Categories>? categoriesList;
  List<List<ChildCategory>>?childCategoryList;
  int? selectedCountryId;
  String? selectedCountryName;
  int? selectedCityId;
  String? selectedCityName;
  bool isCity=true;
  int? selectedCategoryId;
  double? selectedDistance = 10;
  LocationData? getCurrentLocation;
  LatLng? filterLocation;
  String ?currentLocationCityName;
  LatLngBounds? filterBounds;
  String failureMessegae = "";
  bool isCurrent = false;
  int index=0;
  TextEditingController searchController = TextEditingController();
  Future<void> getServices(GetServicesRequest requestData) async {
    emit(ServiceLoading());

    final result = await _getServices(requestData);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (services) => emit(ServiceSuccess(services)),
    );
  }

  Future<void> getCategories() async {
    // emit(CountryCategoryLoading());

    final result = await _getCategories();
    result.fold((failure) {
      failureMessegae = failure.message;
      // emit(CountryCategoryError(failure.message)),
    }, (categories) {
      categoriesList = categories;
      // for(int i=0;i<categoriesList!.length;i++){
      //   var chid=categoriesList?[i].children;
      //   for(int j=0;j<chid!.length;i++){
      //     childCategoryList?[i].add(chid[j]);
      //   }
      // }
      // }
      // print('the final list is now of child ############################  ${childCategoryList}');
      // emit(CountryCategorySuccess());
    });
  }

  Future<void> getCountries() async {
    // emit(CountryCategoryLoading());

    final result = await _getCountries();
    result.fold((failure) {
      failureMessegae = failure.message;

      // emit(CountryCategoryError(failure.message)),
    }, (countries) {
      countriesList = countries;
      // emit(CountryCategorySuccess());
    });
  }

  Future<void> getCountriesAndCategories() async {
    emit(CountryCategoryLoading());
    await getCountries();
    await getCategories();
    if (categoriesList != null && countriesList != null) {
      await getCurrentLocationFilter();
      emit(CountryCategorySuccess());
    } else {
      emit(CountryCategoryError(failureMessegae));
    }
  }

  Future<void> showDetailsUser(int id) async {
    emit(ShowDetailsLoading());

    final result = await _getServiceProfile(id);
    result.fold(
      (failure) => emit(ShowDetailsError(failure.message)),
      (providerProfile) => emit(ShowDetailsSuccess(providerProfile)),
    );
  }

  void selectedCategoryService(int?  categoryId) {
    selectedCategoryId = categoryId;
    
    emit(SelectedCategoryServiceState());
  }

  void selectedCountryService(Countries country) {
    selectedCountryId = country.id;
    selectedCountryName = country.name;
    citiesList = country.cities;
    isUpdat = false;
    emit(SelectedCountryCityServiceState());
  }

  void selectedCityService(Cities city) {
    selectedCityId = city.id;
    selectedCityName = city.name;

    emit(SelectedCountryCityServiceState());
  }

  bool isUpdat = false;
  Future<void> getCurrentLocationFilter() async {
    try {
      emit(GetCurrentLocationFilterLoading());
      LocationData getCurrentLocationData =
          await LocationService.getLocationData();
      getCurrentLocation = getCurrentLocationData;
      isUpdat = true;
      emit(GetCurrentLocationFilterSuccess());
    } catch (e) {
      emit(GetCurrentLocationFilterErrorr("Couldn't get your location"));
    }
  }

  void distanceSelect(double value) {
    selectedDistance = value;

    emit(DistanceSelectUpdate());
  }

  void chooseCurrentLocation(bool value) {
    isCurrent = value;
    emit(IsCurrentLocation());
  }
}
