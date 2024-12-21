import 'dart:io';

import 'package:app/core/models/google_map_model.dart';
import 'package:app/core/utils/map_helper/location_service.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/auth/domain/use_cases/getCountryName.dart';
import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_city.dart';
import 'package:app/features/profile/domain/use_cases/add_image_photo.dart';
import 'package:app/features/profile/domain/use_cases/update_client_profile.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:app/features/service/domain/use_cases/get_categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/profile/domain/use_cases/get_client_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_provider_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_user_role.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:location/location.dart';

import '../../domain/use_cases/update_provider_profile.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(
      this._getClientProfile,
      this._getProviderProfile,
      this._getUserRole,
      this._updateClientProfile,
      this._updateProviderProfile,
      this._getCategories,
      this._getCountryCityName,
      this._addImagePhoto)
      : super(ProfileInitial());
  final GetClientProfile _getClientProfile;
  final GetProviderProfile _getProviderProfile;
  final GetUserRole _getUserRole;
  final UpdateClientProfile _updateClientProfile;
  final UpdateProviderProfile _updateProviderProfile;
  final GetCategories _getCategories;
  final AddImagePhoto _addImagePhoto;

  //variable
  Categories? parent;
  ChildCategory? child;
  TextEditingController emailEditController = TextEditingController();
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Categories? selectedCategory;
  List<Categories>? categoriesList;
  List<ChildCategory>? catChildren;
  String? selectedSubCategoryId;
  ChildCategory? selectedSubCategory;
  final Getcountryname _getCountryCityName;
  ProviderProfile? providerProfile;
   String? latitu;
   String? longti;
  List<DateSelect> dateSelect = [
    DateSelect(day: "Sunday", start: "08:00", end: "15:00"),
    DateSelect(day: "Monday", start: "08:00", end: "15:00"),
    DateSelect(day: "Tuesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Wednesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Thursday", start: "08:00", end: "15:00"),
    DateSelect(day: "Friday", start: "08:00", end: "15:00"),
    DateSelect(day: "Saturday", start: "08:00", end: "15:00"),
  ];
  DateSelect? dateSelected;
  LatLng? currentLocation;
  String? cityName;
  LatLng? myLocation;
  LatLng?oldLocation;
  Country? country;
  ProviderProfileCity ?city;
  Future<void> getClientProfile() async {
    emit(GetProfileLoading());
    final result = await _getClientProfile();
    result.fold(
      (failure) => emit(
        GetProfileErrorr(failure.message),
      ),
      (client) => emit(
        GetClientSuccess(client),
      ),
    );
  }

  Future<void> getCategories() async {
    emit(GetCategoryLoading());

    final result = await _getCategories();
    result.fold((failure) {

      emit(GetCategoryError(failure.message));
    }, (categories) {
      categoriesList = categories;
      if(providerProfile!.details!.category!.parent==null){
        final parentName=providerProfile?.details?.category?.name;

        parent=categoriesList?.firstWhere((element) {
          return  element.name==parentName;
        },);

        selectedCategory=parent;
        catChildren=parent?.children;

      }
      else {
        final parentName =providerProfile?.details?.category
            ?.parent?.name;
        final childName = providerProfile?.details?.category?.name;

        parent=categoriesList?.firstWhere((element) {
          return  element.name==parentName;
        },);

        child=parent?.children.firstWhere((element){
          return  element.name==  childName;
        });
        selectedCategory=parent;
        selectedSubCategory=child;
        catChildren=parent?.children;
      }
      emit(GetCategorySuccess());
    });
  }

// Future<void> getCategories() async {
//   // emit(CountryCategoryLoading());
//   final result = await _getCategories();
  //   result.fold((failure) {
  //     failureMessegae = failure.message;
  //     // emit(CountryCategoryError(failure.message)),
  //   }, (categories) {
  //     categoriesList = categories;
  //     // for(int i=0;i<categoriesList!.length;i++){
  //     //   var chid=categoriesList?[i].children;
  //     //   for(int j=0;j<chid!.length;i++){
  //     //     childCategoryList?[i].add(chid[j]);
  //     //   }
  //     // }
  //     // }
  //     // print('the final list is now of child ############################  ${childCategoryList}');
  //     // emit(CountryCategorySuccess());
  //   });
  // }
  Future<void> getProviderProfile() async {
    emit(GetProfileLoading());
    final result = await _getProviderProfile();
    result.fold(
      (failure) => emit(
        GetProfileErrorr(failure.message),
      ),
          (data) {
            providerProfile=ProviderProfile(id: data.id,email: data.email,firstName: data.firstName,imagePath: data.imagePath,lastName: data.lastName,details: data.details);

             emit(
        GetProviderSuccess(data),
          );}
    );
  }

  void getUserRole() {
    emit(GetProfileLoading());

    final result = _getUserRole();
    result.fold(
        (failure) => emit(
              GetUserRoleErrorr(failure.message),
            ), (role) {
      if (role == "ServiceProvider") {
        getProviderProfile();
      } else if (role == "Client") {
        getClientProfile();
      } else {
        emit(GetProfileErrorr(role));
      }
    });
  }

  void updateClientProfile(UpdateAccountProfile updateRequest) async {
    emit(UpdateLoading());
    final result = await _updateClientProfile(updateRequest);
    result.fold((failure) => emit(UpdateError(failure.message)),
        (updateRequest) {
      emit(UpdateSuccess());
    });
  }

  void updateProviderProfile(
      UpdateProviderRequest updateRequest, int typeEdit) async {
    emit(UpdateLoading());
    final result = await _updateProviderProfile(updateRequest, typeEdit);
    result.fold((failure) => emit(UpdateError(failure.message)),
        (updateRequest) {
      emit(UpdateSuccess());
    });
  }

  updateInfo(
      {required String curFirst,
      required String newFirst,
      required String curLast,
      required String newLast}) {
    if (curFirst == newFirst && curLast == newLast) {
      emit(IsNotUpdated());
    } else {
      emit(IsUpdated());
    }
  }

  updateJobDetails(
      {required String curServiceName,

      required String newServiceName,
      required String curDescription,
      required String newDescription

      }) {
    if (curServiceName == newServiceName && curDescription == newDescription) {
      emit(IsNotUpdated());
    } else {
      emit(IsUpdated());
    }
  }

  onDayUpdate(bool daySelect, DateSelect date) {
    date.daySelect = daySelect;
    emit(CardState());
  }

  onArrowUpdate(bool arrowSelect, DateSelect date) {
    date.arrowSelect = arrowSelect;
    emit(CardState());
  }

  onStartTimeUpdate(String start, DateSelect date) {
    date.start = start;
    emit(CardState());
  }

  onEndTimeUpdate(String end, DateSelect date) {
    date.end = end;
    emit(CardState());
  }

  bool isAnotherDaySelected() {
    for (int i = 0; i < dateSelect.length; i++) {
      if (dateSelect[i].daySelect) {
        return true;
      }
    }
    return false;
  }

  void selectedCategoryEvent(Categories? category) {
    // selectedCategoryId = category!.id.toString();
    selectedCategory = category;
    selectedCategory!=parent?
      emit(IsUpdated()):emit(IsNotUpdated());
    
    selectedSubCategory = null;

    catChildren = category?.children;
    emit(SelectedCategoryState());
  }

  void selectedSubCategoryEvent(ChildCategory category) {
    selectedSubCategory = category;
    selectedSubCategory!=child?
    emit(IsUpdated()):emit(IsNotUpdated());
    
    selectedSubCategoryId = category.id.toString();
    emit(SelectedCategoryState());
  }

  bool isCurrent = true;

  String? mapStyle;

  Set<Marker> markers = {};
  GoogleMapController? googleMapController;
  List<GoogleMapModel> markerLocationData = [];
  bool isCountySuccess = false;

  void initMarkerAddress() {
    markers.clear();
    var myMarker = markerLocationData
        .map(
          (e) => Marker(
            position: e.latLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(e.color),

            infoWindow: InfoWindow(title: e.name),
            markerId: MarkerId(
              e.id.toString(),
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarker);
    markerLocationData.clear();
  }

  void initCurrentLocation() {
    CameraPosition newLocation = CameraPosition(
        target: myLocation!, zoom: 15);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(newLocation));

    markerLocationData.add(GoogleMapModel(
        BitmapDescriptor.hueGreen,
        id: 1,

        name: "your location",
        latLng: myLocation!));
    emit(SelectedLocationUpdatedState());
  }

  Future<void> getCurrentLocation() async {
    try {
      emit(GetUpdatedLocationLoading());
      LocationData getCurrentLocation = await LocationService.getLocationData();
      currentLocation =
          LatLng(getCurrentLocation.latitude!, getCurrentLocation.longitude!);
      emit(GetUpdatedLocationSuccess());
    } catch (e) {
      emit(GetUpdatedLocationErrorr("Couldn't get your location"));
    }
  }

  void selectLocation(LatLng onSelectedLocation) {
    markerLocationData.add(GoogleMapModel(
      BitmapDescriptor.hueGreen,
      id: 1,
      name: "your Location",
      latLng: LatLng(onSelectedLocation.latitude, onSelectedLocation.longitude),
    ));


    emit(SelectedLocationUpdatedState());
  }

  void getCountryAndCityNameFromCrocd(double lat, double long) async {
    
   lat!=latitu&&long!=longti? emit(IsUpdated()):emit(IsNotUpdated());

    emit(GetLocationCountryLoading());
    isCountySuccess = false;
    cityName = null;
    final result = await _getCountryCityName(lat, long);

    result.fold((failure) => emit(GetLocationCountryErrorr(failure.message)),
        (response) {
      cityName = response.cityName;
      isCountySuccess = true;
      country = response;
      emit(GetLocationCountrySuccess());
    });
  }

  Future<void> loadMapStyle(bool isDark) async {
    try {
      mapStyle = await rootBundle.loadString(
          "asset/map_styles/${isDark ? "night_map_style.json" : "light_map_style.json"}");
      // emit(MapStyleLoading());
    } catch (e) {
      // emit(MapStyleError("Failed to load map style."));
    }
  }

  void addImagePhoto(File image) async {
    print(
        'the image work and this is Image  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${image}');
    emit(LoadImagePhotoLoading());
    final result = await _addImagePhoto(image);
    result.fold((failure) {
      print(
          'There are Error bakkkkkkkkkkkkkkar here now #########################################');
      emit(LoadImagePhotoError(failure.message));
    }, (response) {
      emit(LoadImagePhotoSuccess(response.data!));
    });
  }
}
