import 'package:app/core/error/apiResult.dart';
import 'package:app/features/discount/domain/entity/all_discount_entity.dart';
import 'package:app/features/discount/domain/useCase/get_discount.dart';
import 'package:app/features/service/data/models/get_all_category_response/data.dart';
import 'package:app/features/service/data/models/get_all_countries_response/data.dart';
import 'package:app/features/service/domain/entities/main_category/data_of_item_main_category.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/domain/use_cases/get_main_category.dart';
import 'package:app/features/service/domain/use_cases/get_notifications.dart';
import 'package:app/main.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@singleton
class ServiceCubit extends Cubit<ServiceStates> {
  ServiceCubit(
    this._getServices,
    this._getCountries,
    this._getCategories,
    // this._getServiceProfile,
    this._getNotifications,
    this._getAllDiscountUseCase,
    this._getMainCategory,
  ) : super(ServiceInitial());
  final GetCountriesUseCase _getCountries;
  final GetCategoriesUseCase _getCategories;
  final GetServicesUseCase _getServices;
  // final GetServiceProfile _getServiceProfile;
  final GetNotificationsUseCase _getNotifications;
  final GetAllDiscountUseCase _getAllDiscountUseCase;
  final GetMainCategoryUseCase _getMainCategory;

  List<AllDiscountEntity> listAllDiscount = [];
  List<Countries>? countriesList;
  Categories? selectedCategory;
  List<Cities>? citiesList;
  List<Categories>? categoriesList;
  List<DataOfItemMainCategoryEntity> listOfAllMainCategory = [];
  // int? selectedCountryId;
  Countries? selectedCountry;

  // String? selectedCountryName;
  
  Cities? selectedCity;
  // String? selectedCityName;
  bool isCity = true;
  double? selectedDistance = 10;
  LocationData? getCurrentLocation;

  LatLng? filterLocation;
  
  LatLngBounds? filterBounds;
  String failureMessegae = "";
  bool isCurrent = false;
  
  List<Notifications> listNotification = [];
  
  TextEditingController searchController = TextEditingController();

  getServiceAndDiscount() {
    final requestData = GetServicesRequest(
        categoryId: selectedCategory?.id,
        cityId: selectedCity?.id == -1 ? null : selectedCity?.id,
        countryId: selectedCountry?.id == -1 ? null : selectedCountry?.id,
        latitude: getCurrentLocation?.latitude,
        longitude: getCurrentLocation?.longitude,
        radius: selectedDistance?.toInt(),
        search: searchController.text.isEmpty ? null : searchController.text);
    Future.wait([_getAllServices(requestData), _getAllDiscount()]);
  }

  Future<void> _getAllServices(GetServicesRequest requestData) async {
    emit(ServiceLoading());
    
    print(
        'category ${requestData.categoryId} and country ${requestData.countryId} and city ${requestData.cityId} and radius ${requestData.radius} and search ${requestData.search}');

    print('');
    final result = await _getServices(requestData);
    result.fold((failure) => emit(ServiceError(failure.message)), (services) {
      // print('we emit the successs state in get service ');
      emit(ServiceSuccess(services));
    });
  }

  Future<void> _getAllDiscount() async {
    listAllDiscount.clear();

    emit(GetDiscountLoadingState());

    final ans = await _getAllDiscountUseCase();
    switch (ans) {
      case ApiResultSuccess():
        {
          listAllDiscount = ans.data;
          emit(GetDiscountSuccessState<List<AllDiscountEntity>>(ans.data));
        }
      case ApiresultError():
        {
          emit(GetDiscountFailState());
        }
    }
  }

  Future<void> getAllNotification() async {
    emit(GetNotificationLoading());

    final result = await _getNotifications();
    result.fold(
      (failure) => emit(GetNotificationError(failure.message)),
      (notification) {
        listNotification = notification;
        emit(GetNotificationSuccess());
      },
    );
  }

  Future<void> getCategories() async {
    // emit(CountryCategoryLoading());
    final result = await _getCategories();
    result.fold((failure) {
      failureMessegae = failure.message;
      emit(CountryCategoryError(failure.message));
    }, (categories) {
      categoriesList = categories;
      DataCategory addAllCategories = DataCategory(
          name: AppLocalizations.of(navigatorKey.currentContext!)!.allCategory,
          id: -1,
          children: []);
      categoriesList?.add(addAllCategories);
    });
  }

  Future<void> getCountries() async {
    // emit(CountryCategoryLoading());

    final result = await _getCountries();
    result.fold((failure) {
      failureMessegae = failure.message;

      emit(CountryCategoryError(failure.message));
    }, (countries) {
      // countriesList?.clear();
      countriesList = countries;
      DataCountries addAllCountry = DataCountries(
          id: -1,
          name: AppLocalizations.of(navigatorKey.currentContext!)!.allCountries,
          cities: []);
      countriesList?.add(addAllCountry);
      emit(CountryCategorySuccess());
    });
  }

  
  Future<void> getCountriesAndCategories() async {
    selectedCity = null;
    selectedCategory = null;
    selectedCountry = null;
    emit(CountryCategoryLoading());
    Future.wait([getCountries(), getCategories()]);

    // if (categoriesList != null && countriesList != null) {
    //   // await getCurrentLocationFilter();
    //   emit(CountryCategorySuccess());
    // } else {
    //   emit(CountryCategoryError(failureMessegae));
    // }
  }

  // Future<void> showDetailsUser(int id) async {
  //   emit(ShowDetailsLoading());

  //   final result = await _getServiceProfile(id);
  //   result.fold(
  //     (failure) => emit(ShowDetailsError(failure.message)),
  //     (providerProfile) => emit(ShowDetailsSuccess(providerProfile)),
  //   );
  // }

  // void selectedCountryService(Countries country) {
  //   // selectedCountryId = country.id;
  //   // selectedCountryName = country.name;

  //   selectedCountry = country;
  //   // Initialize or update the cities list based on the selected country
  //   if (country.cities.isNotEmpty) {
  //     citiesList = List.from(country.cities); // Use a new list instance
  //   } else {
  //     citiesList = []; // Reset to an empty list if there are no cities
  //   }

  //   // Add the "All Cities" option to the list
  //   citiesList?.add(addAllCities);

  //   // isUpdat = false; // Reset update flag
  //   emit(SelectedCountryCityServiceState());
  // }

  // void selectedCityService(Cities city) {
  //   // selectedCityId = city.id;
  //   // selectedCityName = city.name;
  //   selectedCity = city;
  //   emit(SelectedCountryCityServiceState());
  // }

  // bool isUpdat = false;
  Future<void> getCurrentLocationFilter() async {
    emit(GetCurrentLocationFilterLoading());
    final result = await LocationService.getLocationData();
    result.fold(
        (failure) =>
            emit(GetCurrentLocationFilterErrorr("Couldn't get your location")),
        (location) {
      getCurrentLocation = location;
      // isUpdat = true;
      emit(GetCurrentLocationFilterSuccess());
    });
    // try {
    //   emit(GetCurrentLocationFilterLoading());
    //   LocationData getCurrentLocationData =
    //       await LocationService.getLocationData();
    //   getCurrentLocation = getCurrentLocationData;
    //   isUpdat = true;
    //   emit(GetCurrentLocationFilterSuccess());
    // } catch (e) {
    //   emit(GetCurrentLocationFilterErrorr("Couldn't get your location"));
    // }
  }

  // void distanceSelect(double value) {
  //   selectedDistance = value;

  //   emit(DistanceSelectUpdate());
  // }

  // void chooseCurrentLocation(bool value) {
  //   isCurrent = value;
  //   emit(IsCurrentLocation());
  // }

  bool? isReset = false;
  void resetSetting() {
    searchController.clear();
    selectedCountry = null;
    selectedCity = null;
    selectedCategory = null;
    isCurrent = false;
    selectedDistance = 10;
    isReset = true;
    emit(ResetSettingsState());
  }

  getAllMainCategory() async {
    emit(GetMainCategoryLoading());
    final result = await _getMainCategory();
    result.fold((failure) {
      emit(GetMainCategoryError(failure.message));
    }, (list) {
      listOfAllMainCategory = list.listOfItemMainCategory;
      emit(GetMainCategorySuccess());
    });
  }
}
