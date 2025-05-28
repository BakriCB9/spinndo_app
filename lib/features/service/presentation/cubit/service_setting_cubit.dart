import 'package:app/core/const_variable.dart';
import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/error/apiResult.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/utils/map_helper/location_service.dart';
import 'package:app/features/discount/domain/entity/all_discount_entity.dart';
import 'package:app/features/discount/domain/useCase/get_discount.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/google_map/domain/entity/marker_location.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/service/data/models/get_all_category_response/data.dart';
import 'package:app/features/service/data/models/get_all_countries_response/data.dart';
import 'package:app/features/service/data/models/get_services_request.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/cities.dart';
import 'package:app/features/service/domain/entities/countries.dart';
import 'package:app/features/service/domain/entities/main_category/data_of_item_main_category.dart';
import 'package:app/features/service/domain/entities/notifications.dart';
import 'package:app/features/service/domain/entities/services.dart';
import 'package:app/features/service/domain/use_cases/get_categories.dart';
import 'package:app/features/service/domain/use_cases/get_countries.dart';
import 'package:app/features/service/domain/use_cases/get_details.dart';
import 'package:app/features/service/domain/use_cases/get_main_category.dart';
import 'package:app/features/service/domain/use_cases/get_notifications.dart';
import 'package:app/features/service/domain/use_cases/get_services.dart';
import 'package:app/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'service_setting_state.dart';

@singleton
class ServiceSettingCubit extends Cubit<ServiceSettingState> {
  ServiceSettingCubit(
      this._getCountriesUseCase,
      this._getCategoriesUseCase,
      this._getServicesUseCase,
      this._getAllDiscountUseCase,
      this._getServiceProfileUseCase,
      this._getNotificationsUseCase,
      this._getMainCategoryUseCase)
      : super(ServiceSettingState());
  final GetCountriesUseCase _getCountriesUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetServicesUseCase _getServicesUseCase;
  final GetAllDiscountUseCase _getAllDiscountUseCase;
  final GetServiceProfileUseCase _getServiceProfileUseCase;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final GetMainCategoryUseCase _getMainCategoryUseCase;

  Future<void> getCurrentLocationFilter() async {
    emit(state.copyWith(getCurrentLocation: BaseLoadingState()));
    final result = await LocationService.getLocationData();
    result.fold(
        (failure) =>
            emit(state.copyWith(getCurrentLocation: BaseErrorState(null))),
        (location) {
      getCurrentLocation = location;

      getCountriesAndCategories();
      emit(state.copyWith(getCurrentLocation: BaseSuccessState()));
    });
  }

  Future<void> getCountriesAndCategories() async {
    selectedCity = null;
    selectedCategory = null;
    selectedCountry = null;
    emit(state.copyWith(getCountryAndCategory: BaseLoadingState()));
    try {
      final result1 = await _getCountriesUseCase();
      final result2 = await _getCategoriesUseCase();
      result1.fold((failure) {
        throw Exception(failure.message);
      }, (countries) {
        countriesList = countries;
        // DataCountries addAllCountry = DataCountries(
        //     id: -1,
        //     name:
        //         AppLocalizations.of(navigatorKey.currentContext!)!.allCountries,
        //     cities: []);
        // countriesList?.add(addAllCountry);
      });

      result2.fold((failure) {
        throw Exception(failure.message);
      }, (categories) {
        categoriesList = categories;
        DataCategory addAllCategories = DataCategory(
            name:
                AppLocalizations.of(navigatorKey.currentContext!)!.allCategory,
            id: -1,
            children: []);
        categoriesList?.add(addAllCategories);
        emit(state.copyWith(getCountryAndCategory: BaseSuccessState()));
      });
      emit(state.copyWith(getCountryAndCategory: BaseSuccessState()));
    } catch (e) {
      emit(state.copyWith(getCountryAndCategory: BaseErrorState(e.toString())));
    }
  }

  getServiceAndDiscount({String? sortType}) async {
    final int? userId = serviceLocator
        .get<SharedPreferencesUtils>()
        .getData(key: CacheConstant.userId) as int?;
    markerLocationData.clear();
    final requestData = GetServicesRequest(
        sort: sortType,
        categoryId: idOfMainCategory ?? selectedCategory?.id,
        cityId: selectedCity?.id == -1 ? null : selectedCity?.id,
        countryId: selectedCountry?.id == -1 ? null : selectedCountry?.id,
        latitude: getCurrentLocation?.latitude,
        longitude: getCurrentLocation?.longitude,
        radius: selectedDistance?.toInt(),
        search: searchController.text.isEmpty ? null : searchController.text,
        userId: userId?.toString());

    emit(state.copyWith(
        getAllServiceState: BaseLoadingState(),
        getAllDiscountState: BaseLoadingState()));
    try {
      final resultOfdiscount = await _getAllDiscountUseCase();
      final resultOfService = await _getServicesUseCase(requestData);

      switch (resultOfdiscount) {
        case ApiResultSuccess():
          {}
        case ApiresultError():
          {
            throw Exception(resultOfdiscount.message);
          }
      }
      resultOfService.fold((failure) {
        throw Exception(failure.message);
      }, (service) {
        emit(state.copyWith(
            getAllServiceState: BaseSuccessState<List<Services>>(data: service),
            getAllDiscountState: BaseSuccessState<List<AllDiscountEntity>>(
                data: (resultOfdiscount as ApiResultSuccess).data)));
      });
      //Discount_Data
    } catch (e) {
      emit(state.copyWith(
          getAllServiceState: BaseErrorState(e.toString()),
          getAllDiscountState: BaseErrorState(e.toString())));
    }
  }

  Future<void> showDetailsUser(int id) async {
    emit(state.copyWith(getDetailsUserState: BaseLoadingState()));

    final result = await _getServiceProfileUseCase(id);
    result.fold(
      (failure) => emit(
          state.copyWith(getDetailsUserState: BaseErrorState(failure.message))),
      (providerProfile) => emit(state.copyWith(
          getDetailsUserState:
              BaseSuccessState<ProviderProfile>(data: providerProfile))),
    );
  }

  Future<void> getAllNotification() async {
    emit(state.copyWith(getAllNotificationState: BaseLoadingState()));

    final result = await _getNotificationsUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
          getAllNotificationState: BaseErrorState(failure.message))),
      (notification) {
        emit(state.copyWith(
            getAllNotificationState:
                BaseSuccessState<List<Notifications>>(data: notification)));
      },
    );
  }

  getAllMainCategory() async {
    emit(state.copyWith(getMainCategoryState: BaseLoadingState()));
    final result = await _getMainCategoryUseCase();
    result.fold((failure) {
      emit(state.copyWith(
          getMainCategoryState: BaseErrorState(failure.message)));
    }, (list) {
      // listOfAllMainCategory = list.listOfItemMainCategory;
      emit(state.copyWith(
          getMainCategoryState:
              BaseSuccessState<List<DataOfItemMainCategoryEntity>>(
                  data: list.listOfItemMainCategory)));
    });
  }

  resetAllData() {
    emit(state.copyWith(resetData: false));
    searchController.clear();
    selectedCity = null;
    selectedCategory = null;
    selectedCountry = null;
    isCurrent = false;
    isReset = true;
    emit(state.copyWith(resetData: true));
  }

  Countries? selectedCountry;
  Categories? selectedCategory;
  int? idOfMainCategory;
  Cities? selectedCity;
  List<Cities>? citiesList;
  List<Countries>? countriesList;
  List<Categories>? categoriesList;
  bool isCurrent = false;
  double? selectedDistance = 10;
  LatLng? filterLocation;
  bool? isReset = false;
  LocationData? getCurrentLocation;
  TextEditingController searchController = TextEditingController();
  Set<Marker> listOfMarkers = {};
}
