import 'dart:io';

import 'package:app/core/models/google_map_model.dart';
import 'package:app/core/utils/map_helper/location_service.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/auth/domain/use_cases/getCountryName.dart';
import 'package:app/features/profile/data/models/client_update/update_account_profile.dart';
import 'package:app/features/profile/data/models/provider_update/update_provider_request.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_request.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_porfile_category.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile.dart';
import 'package:app/features/profile/domain/entities/provider_profile/provider_profile_city.dart';
import 'package:app/features/profile/domain/use_cases/add_image_photo.dart';
import 'package:app/features/profile/domain/use_cases/add_or_update_social.dart';
import 'package:app/features/profile/domain/use_cases/delete_image.dart';
import 'package:app/features/profile/domain/use_cases/delete_social_links.dart';
import 'package:app/features/profile/domain/use_cases/update_client_profile.dart';
import 'package:app/features/service/domain/entities/categories.dart';

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
      this._addImagePhoto,
      this._deleteImage,
      this._addOrUpdateSocialUseCase,
      this._deleteSocialLinksUseCase)
      : super(ProfileInitial());
  final GetClientProfile _getClientProfile;
  final GetProviderProfile _getProviderProfile;
  final GetUserRole _getUserRole;
  final UpdateClientProfile _updateClientProfile;
  final UpdateProviderProfile _updateProviderProfile;
  final GetCategoriesUseCase _getCategories;
  final AddImagePhoto _addImagePhoto;
  final DeleteImage _deleteImage;
  final AddOrUpdateSocialUseCase _addOrUpdateSocialUseCase;
  final DeleteSocialLinksUseCase _deleteSocialLinksUseCase;

  //variable
  // Categories? parent;
  // Categories? child;
  TextEditingController emailEditController = TextEditingController();
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController firstNameArEditController = TextEditingController();
  TextEditingController lastNameArEditController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneEditController = TextEditingController();
  Categories? selectedCategory;
  List<Categories>? categoriesList;
  List<Categories>? catChildren;
  String? selectedSubCategoryId;
  Categories? selectedSubCategory;
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
  LatLng? oldLocation;
  Country? country;
  List<Categories?> chosenCategories = [];

  ProviderProfileCity? city;
//   void extractCategoryNames(ProviderProfileCategory? category,List<Categories>? categoriesListll) {
//     List<Categories?> names = [];
// Categories ?name;
//     // Traverse up the parent hierarchy
//     while (category != null) {
//
//       name = categoriesListll?.firstWhere(
//             (element) => element.name == category?.name,
//         orElse: () => Categories(name: "name", id: -50, children: []), // Return null if no match is found
//       );
//
//       if (name != null&&name.id!=-50) {
//         names.add(name);
//       }
//       category = category.parent ; // Move to the parent category
//     }
//
//     // Reverse the list to start with the root category
//     chosenCategories =names.reversed.toList();
//   }

  void extractCategoryNames(
      ProviderProfileCategory? category, List<Categories>? categoriesList) {
    List<Categories?> names = [];
    Categories? name;
    // Helper function to find a category by name recursively
    Categories? findCategoryByName(List<Categories> categories, String? name) {
      for (var cat in categories) {
        if (cat.name == name) {
          return cat;
        }
        if (cat.children.isNotEmpty) {
          final result = findCategoryByName(cat.children, name);
          if (result != null) {
            return result;
          }
        }
      }
      return null; // Not found
    }

    // Traverse the ProviderProfileCategory hierarchy
    while (category != null) {
      name = findCategoryByName(categoriesList ?? [], category.name);

      if (name != null) {
        names.add(name);
      }

      category = category.parent; // Move to the parent category
    }

    // Reverse the list to start with the root category
    chosenCategories = names.reversed.toList();
  }

  void slesctedProfileCat() {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(selectedCategory?.id);
    print(providerProfile?.details?.category?.id);
    print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
    selectedCategory?.id != providerProfile?.details?.category?.id
        ? emit(IsUpdated())
        : emit(IsNotUpdated());

    emit(SelectedCategoryState());
  }

  Future<void> getCategories() async {
    emit(GetCategoryLoading());

    final result = await _getCategories();
    result.fold((failure) {
      emit(GetCategoryError(failure.message));
    }, (categories) {
      categoriesList = categories;
      extractCategoryNames(providerProfile?.details?.category, categoriesList);

      emit(GetCategorySuccess());
      slesctedProfileCat();
    });
  }

  Future<void> getProviderProfile() async {
    emit(GetProfileLoading());

    final result = await _getProviderProfile();
    result.fold((failure) {
      print(
          'we emit error state in getProviderProfile now wwwwwwwwwwwwwwwwwwwwwwwwwwww');
      emit(
        GetProfileErrorr(failure.message),
      );
    }, (data) {
      print('now i currently get provider profile');
      providerProfile = ProviderProfile(
          id: data.id,
          email: data.email,
          phone: data.phone,
          firstName: data.firstName,
          imagePath: data.imagePath,
          lastName: data.lastName,
          details: data.details);

      emit(
        GetProviderSuccess(data),
      );
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

  void getUserRole() {
    print('the user role is now bakkkkar aweja ');
    emit(GetProfileLoading());

    final result = _getUserRole();
    print('the result of role is ${result}');
    result.fold(
        (failure) => emit(
              GetUserRoleErrorr(failure.message),
            ), (role) {
      if (role == "ServiceProvider") {
        print('we stand in userProvider role now');
        getProviderProfile();
      } else if (role == "Client") {
        getClientProfile();
      } else {
        emit(GetProfileErrorr(role));
      }
    });
  }

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

  void updateClientProfile(UpdateAccountProfile updateRequest) async {
    emit(UpdateLoading());
    final result = await _updateClientProfile(updateRequest);
    result.fold((failure) => emit(UpdateError(failure.message)),
        (updateRequest) {
      emit(UpdateSuccess());
    });
  }

  updateInfo(
      {required String curFirst,
       required String curFirstAr,
       required String newFirstAr,
       required String curLastAr,
       required String newLastAr,
      required String newFirst,
      required String curLast,
      required String newLast,
        required String curEmail,
        required String newEmail,
      }) {
    if (curFirst == newFirst && curFirstAr == newFirstAr&& curLast == newLast&& curLastAr == newLastAr && curEmail == newEmail) {
      emit(IsNotUpdated());
    } else {
      emit(IsUpdated());
    }
  }

  updateJobDetails(
      {required String curServiceName,
      required String newServiceName,
      required String curDescription,
      required String newDescription}) {
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
    CameraPosition newLocation = CameraPosition(target: myLocation!, zoom: 15);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(newLocation));

    markerLocationData.add(GoogleMapModel(BitmapDescriptor.hueGreen,
        id: 1, name: "your location", latLng: myLocation!));
    emit(SelectedLocationUpdatedState());
  }

  Future<void> getCurrentLocation() async {
    
    // try {
    //   emit(GetUpdatedLocationLoading());
    //   LocationData getCurrentLocation = await LocationService.getLocationData();
    //   currentLocation =
    //       LatLng(getCurrentLocation.latitude!, getCurrentLocation.longitude!);
    //   emit(GetUpdatedLocationSuccess());
    // } catch (e) {
    //   emit(GetUpdatedLocationErrorr("Couldn't get your location"));
    // }
    emit(GetUpdatedLocationLoading());
    final result=await LocationService.getLocationData();
    result.fold((failure)=>emit(GetUpdatedLocationErrorr("Couldn't get your location")), (location){
         currentLocation =
          LatLng(location.latitude!, location.longitude!);
             emit(GetUpdatedLocationSuccess());
    });
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
    lat != latitu && long != longti ? emit(IsUpdated()) : emit(IsNotUpdated());

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
    emit(LoadImagePhotoLoading());
    final result = await _addImagePhoto(image);
    result.fold((failure) {
      emit(LoadImagePhotoError(failure.message));
    }, (response) {
      emit(LoadImagePhotoSuccess(response.data!));
    });
  }

  void deleteImage() async {
    emit(LoadImagePhotoLoading());
    final result = await _deleteImage();
    result.fold((failure) {
      emit(LoadImagePhotoError(failure.message));
    }, (response) {
      emit(LoadImagePhotoSuccess(response.data!));
    });
  }

  addOrupdateSoical(SocialMediaLinksRequest socialMediaLinksRequest) async {
    emit(AddorUpdateSoicalLinksLoading());
    final result = await _addOrUpdateSocialUseCase(socialMediaLinksRequest);
    result.fold((failure) {
      emit(AddorUpdateSoicalLinksError(failure.message));
    }, (response) {
      emit(AddorUpdateSoicalLinksSuccess(response));
    });
  }

  deleteSocialLinks(int idOfSocial) async {
    emit(DeleteSocialLinkLoading());
    final result = await _deleteSocialLinksUseCase(idOfSocial);
    result.fold((failure) {
      emit(DeleteSocialLinkError(failure.message));
    }, (response) {
      emit(DeleteSocialLinkSuccess(response));
    });
  }
}
