import 'dart:async';
import 'dart:io';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/service/domain/entities/child_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

import 'package:app/core/utils/map_helper/location_service.dart';
import 'package:app/features/auth/data/models/login_request.dart';
import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/reset_password_request.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/domain/use_cases/login.dart';
import 'package:app/features/auth/domain/use_cases/register.dart';
import 'package:app/features/auth/domain/use_cases/register_service.dart';
import 'package:app/features/auth/domain/use_cases/resend_code.dart';
import 'package:app/features/auth/domain/use_cases/reset_password.dart';
import 'package:app/features/auth/domain/use_cases/verify_code.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/use_cases/get_categories.dart';

import '../../../../core/models/google_map_model.dart';
import '../../domain/use_cases/getCountryName.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      this._login,
      this._register,
      this._verifyCode,
      this._registerService,
      this._resendCode,
      this._resetPassword,
      this._getCategories,
      this._getCountryCityName)
      : super(AuthInitial());
  final Login _login;
  final Register _register;
  final VerifyCode _verifyCode;
  final ResendCode _resendCode;
  final ResetPassword _resetPassword;
  final RegisterService _registerService;
  final Getcountryname _getCountryCityName;
  List<DateSelect> dateSelect = [
    DateSelect(day: "Sunday", start: "08:00", end: "15:00"),
    DateSelect(day: "Monday", start: "08:00", end: "15:00"),
    DateSelect(day: "Tuesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Wednesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Thursday", start: "08:00", end: "15:00"),
    DateSelect(day: "Friday", start: "08:00", end: "15:00"),
    DateSelect(day: "Saturday", start: "08:00", end: "15:00"),
  ];
  String website = '';
  final emailController = TextEditingController();

  String locationName = "enter your location";
  LatLng? currentLocation;
  LatLng? selectedLocation;
  Set<Marker> markers = {};
  GoogleMapController? googleMapController;

  final firstNameContoller = TextEditingController();

  final lastNameContoller = TextEditingController();

  final passwordController = TextEditingController();
  final codeController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  final serviceNameController = TextEditingController();
  final addressController = TextEditingController();
  final serviceDescriptionController = TextEditingController();
  bool isClient = true;
  int resendCodeTime = 60;
  Timer? timer;
  bool canResend = false;
  File? certificateImage;
  File? firstImage;
  File? secondImage;
  List<Categories>? categoriesList;
  List<ChildCategory>? catChildren;
  Country? country;
  Categories? selectedCategory;
  ChildCategory? selectedSubCategory;
  final GetCategories _getCategories;
  // String? selectedCategoryId;
  late CameraPosition initialCameraPosition;
  bool isCurrent = true;
  bool isCountySuccess = false;
  String? cityName;
  List<GoogleMapModel> markerLocationData = [];
  Future<void> register(RegisterRequest requestData) async {
    emit(RegisterLoading());
    final result = await _register(requestData);

    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (response) => emit(RegisterSuccess()),
    );
  }

  Future<void> login(LoginRequest requestData) async {
    emit(LoginLoading());

    final result = await _login(requestData);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (response) => emit(LoginSuccess()),
    );
  }

  Future<void> verifyCode(VerifyCodeRequest requestData) async {
    emit(VerifyCodeLoading());

    final result = await _verifyCode(requestData);
    result.fold(
      (failure) => emit(VerifyCodeError(failure.message)),
      (response) => emit(VerifyCodeSuccess()),
    );
  }

  Future<void> registerService(
      RegisterServiceProviderRequest requestData) async {
    emit(RegisterServiceLoading());

    final result = await _registerService(requestData);

    result.fold(
      (failure) => emit(RegisterServiceError(failure.message)),
      (response) => emit(RegisterServiceSuccess()),
    );
  }

  Future<void> resendCode(ResendCodeRequest requestData) async {
    emit(ResendCodeLoading());

    final result = await _resendCode(requestData);
    result.fold(
      (failure) => emit(ResendCodeError(failure.message)),
      (response) {
        // verifyCodeTime();
        emit(ResendCodeSuccess());
      },
    );
  }

  Future<void> resetPassword(ResetPasswordRequest requestData) async {
    emit(ResetPasswordLoading());

    final result = await _resetPassword(requestData);
    result.fold(
      (failure) => emit(ResetPasswordError(failure.message)),
      (response) => emit(ResetPasswordSuccess()),
    );
  }

  onChooseAccountType(bool value) {
    isClient = value;
    emit(ChooseAccountState());
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

  verifyCodeTime() {
    canResend = false;
    emit(CanResendState());

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCodeTime > 0) {
        resendCodeTime -= 1;
        emit(CanResendState());
      } else {
        canResend = true;
        emit(CanResendState());
        resendCodeTime = 60;
        timer.cancel();
      }
    });
  }

  Future<void> getCategories() async {
    emit(GetCategoryLoading());

    final result = await _getCategories();
    result.fold((failure) {
      // failureMessegae=failure.message;
      emit(GetCategoryError(failure.message));
    }, (categories) {
      categoriesList = categories;
      emit(GetCategorySuccess());
    });
  }

  void selectedCategoryEvent(Categories? category) {
    // selectedCategoryId = category!.id.toString();
    selectedCategory = category;
    selectedSubCategory = null;

    catChildren = category?.children;
    emit(SelectedCategoryState());
  }

  void selectedSubCategoryEvent(ChildCategory category) {
    selectedSubCategory = category;
    emit(SelectedCategoryState());
  }

  void initMarkerAddress() {
    markers.clear();
    var myMarker = markerLocationData
        .map(
          (e) => Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(e.color),
            position: e.latLng,
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
    CameraPosition newLocation =
        CameraPosition(target: currentLocation!, zoom: 15);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(newLocation));

    markerLocationData.add(GoogleMapModel(BitmapDescriptor.hueGreen,
        id: 1, name: "your current location", latLng: currentLocation!));
    emit(SelectedLocationState());
  }

  Future<void> getCurrentLocation() async {
    try {
      emit(GetCurrentLocationLoading());
      LocationData getCurrentLocation = await LocationService.getLocationData();
      currentLocation =
          LatLng(getCurrentLocation.latitude!, getCurrentLocation.longitude!);
      emit(GetCurrentLocationSuccess());
    } catch (e) {
      emit(GetCurrentLocationErrorr("Couldn't get your location"));
    }
  }

  void selectLocation(LatLng onSelectedLocation) {
    markerLocationData.add(GoogleMapModel(
      BitmapDescriptor.hueGreen,
      id: 1,
      name: "your Location",
      latLng: LatLng(onSelectedLocation.latitude, onSelectedLocation.longitude),
    ));

    selectedLocation =
        LatLng(onSelectedLocation.latitude, onSelectedLocation.longitude);
    emit(SelectedLocationState());
  }

  void getCountryAndCityNameFromCrocd(double lat, double long) async {
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

  void updateCertificateImage(File? image) {
    certificateImage = image;
    emit(CertificateImageUpdated(image));
  }

  void updateFirstImage(File? image) {
    firstImage = image;
    emit(FirstImageUpdated(image));
  }

  void updateSecondImage(File? image) {
    secondImage = image;
    emit(SecondImageUpdated(image));
  }

  String? mapStyle;

  Future<void> loadMapStyle(bool isDark) async {
    try {
      mapStyle = await rootBundle.loadString(
          "asset/map_styles/${isDark ? "night_map_style.json" : "light_map_style.json"}");
      // emit(MapStyleLoading());
    } catch (e) {
      // emit(MapStyleError("Failed to load map style."));
    }
  }
}
