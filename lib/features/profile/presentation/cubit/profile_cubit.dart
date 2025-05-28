import 'dart:io';
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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:app/features/profile/domain/use_cases/get_client_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_provider_profile.dart';
import 'package:app/features/profile/domain/use_cases/get_user_role.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';

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

  TextEditingController emailEditController = TextEditingController();
  TextEditingController firstNameEditController = TextEditingController();
  TextEditingController lastNameEditController = TextEditingController();
  TextEditingController firstNameArEditController = TextEditingController();
  TextEditingController lastNameArEditController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController webSiteController = TextEditingController();
  Categories? selectedCategory;
  List<Categories>? categoriesList;
  List<Categories>? catChildren;
  String? selectedSubCategoryId;
  Categories? selectedSubCategory;

  ProviderProfile? providerProfile;

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

  String? lat;
  String? long;
  DateSelect? dateSelected;
  String? cityName;
  List<Categories?> chosenCategories = [];
  ProviderProfileCity? city;

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
      emit(
        GetProfileErrorr(failure.message),
      );
    }, (data) {
      providerProfile = ProviderProfile(
          id: data.id,
          email: data.email,
          firstName: data.firstName,
          imagePath: data.imagePath,
          lastName: data.lastName,
          details: data.details);

      emit(
        GetProviderSuccess(data),
      );
    });
  }

  void updateProviderProfile(int typeEdit) async {
    final updateRequest;
    if (typeEdit == 1) {
      updateRequest = UpdateProviderRequest(
        phoneNumber: phoneNumberController.text,
        firstNameAr: firstNameArEditController.text,
        lastNameAr: lastNameArEditController.text,
        firstName: firstNameEditController.text,
        lastName: lastNameEditController.text,
      );
    } else if (typeEdit == 2) {
      updateRequest = UpdateProviderRequest(
          latitudeService: lat,
          longitudeService: long,
          cityNameService: cityName,
          categoryIdService: selectedCategory?.id.toString(),
          nameService: serviceNameController.text,
          descriptionService: descriptionController.text,
          websiteService:
              webSiteController.text.isEmpty ? null : webSiteController.text);
    } else {
      updateRequest = UpdateProviderRequest(listOfDay: dateSelect);
    }
    //
    emit(UpdateLoading());
    final result = await _updateProviderProfile(updateRequest, typeEdit);
    result.fold((failure) => emit(UpdateError(failure.message)),
        (updateRequest) {
      emit(UpdateSuccess());
    });
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

  void updateClientProfile() async {
    final updateRequest = UpdateAccountProfile(
        phoneNumber: phoneNumberController.text,
        firstNameAr: firstNameArEditController.text,
        lastNameAr: lastNameArEditController.text,
        firstName: firstNameEditController.text,
        lastName: lastNameEditController.text);
    emit(UpdateLoading());
    final result = await _updateClientProfile(updateRequest);
    result.fold((failure) => emit(UpdateError(failure.message)),
        (updateRequest) {
      emit(UpdateSuccess());
    });
  }

  updateInfo({
    required String curFirst,
    required String curFirstAr,
    required String newFirstAr,
    required String curLastAr,
    required String newLastAr,
    required String newFirst,
    required String curLast,
    required String newLast,
    required String curphoneNumber,
    required String newPhoneNumber,
  }) {
    if (curphoneNumber == newPhoneNumber &&
        curFirst == newFirst &&
        curFirstAr == newFirstAr &&
        curLast == newLast &&
        curLastAr == newLastAr) {
      emit(IsNotUpdated());
    } else {
      emit(IsUpdated());
    }
  }

  updateJobDetails(
      {required String curServiceName,
      required String newServiceName,
      required String? curWebSite,
      required String? newWebSite,
      required String curDescription,
      required String curLat,
      required String newLat,
      required String curLong,
      required String newLong,
      required String newDescription}) {
    if (curServiceName == newServiceName &&
        curDescription == newDescription &&
        curLat == newLat &&
        curLong == newLong &&
        curWebSite == newWebSite) {
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
