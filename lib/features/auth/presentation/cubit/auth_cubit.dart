import 'dart:async';
import 'dart:io';
import 'package:app/features/auth/data/models/upgeade_regiest_service_provider.dart';
import 'package:app/features/auth/domain/entities/country.dart';
import 'package:app/features/auth/domain/use_cases/upgrade_account_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:app/core/utils/map_helper/location_service.dart';
import 'package:app/features/auth/data/models/register_request.dart';
import 'package:app/features/auth/data/models/register_service_provider_request.dart';
import 'package:app/features/auth/data/models/resend_code_request.dart';
import 'package:app/features/auth/data/models/verify_code_request.dart';
import 'package:app/features/auth/domain/use_cases/register.dart';
import 'package:app/features/auth/domain/use_cases/register_service.dart';
import 'package:app/features/auth/domain/use_cases/resend_code.dart';
import 'package:app/features/auth/domain/use_cases/verify_code.dart';
import 'package:app/features/auth/presentation/cubit/auth_states.dart';
import 'package:app/features/service/domain/entities/categories.dart';
import 'package:app/features/service/domain/use_cases/get_categories.dart';
import '../../../../core/models/google_map_model.dart';
import '../../domain/use_cases/getCountryName.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      this._register,
      this._verifyCode,
      this._registerService,
      this._resendCode,
      this._getCategories,
      this._getCountryCityName,
      this._upgradeAccountUseCase)
      : super(AuthInitial());

  final RegisterUseCase _register;
  final VerifyCodeUseCase _verifyCode;
  final ResendCodeUseCase _resendCode;

  final RegisterServiceUseCase _registerService;
  final Getcountryname _getCountryCityName;
  final UpgradeAccountUseCase _upgradeAccountUseCase;
  List<DateSelect> dateSelect = [
    DateSelect(day: "Sunday", start: "08:00", end: "15:00"),
    DateSelect(day: "Monday", start: "08:00", end: "15:00"),
    DateSelect(day: "Tuesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Wednesday", start: "08:00", end: "15:00"),
    DateSelect(day: "Thursday", start: "08:00", end: "15:00"),
    DateSelect(day: "Friday", start: "08:00", end: "15:00"),
    DateSelect(day: "Saturday", start: "08:00", end: "15:00"),
  ];

  final emailController = TextEditingController();

  String locationName = "enter your location";
  LatLng? currentLocation;
  LatLng? selectedLocation;
  Set<Marker> markers = {};
  GoogleMapController? googleMapController;

  final firstNameContoller = TextEditingController();
  final firstNameArcontroller = TextEditingController();
  final lastNameArCOntroller = TextEditingController();
  final phoneNumberController = TextEditingController();
  String countryCode = '+93';
  final lastNameContoller = TextEditingController();

  final passwordController = TextEditingController();
  final codeController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  final serviceNameController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();
  final serviceDescriptionController = TextEditingController();

  List<File?> listOfFileImagesProtofile = [File("")];
  bool isClient = true;
  int resendCodeTime = 60;
  Timer? timer;
  bool canResend = false;
  File? certificateImage;

  List<Categories>? categoriesList;
  Country? country;
  Categories? selectedCategory;
  final GetCategoriesUseCase _getCategories;

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

  Future<void> upgradeAccount(
      UpgradeRegiestServiceProviderRequest requestData) async {
    emit(RegisterServiceLoading());

    final result = await _upgradeAccountUseCase(requestData);

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
      //selectedAuthCat();
    });
  }

  // void selectedAuthCat() {
  //   emit(SelectedCategoryState());
  // }

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
    markerLocationData.clear();
    CameraPosition newLocation =
        CameraPosition(target: currentLocation!, zoom: 15);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(newLocation));

    markerLocationData.add(GoogleMapModel(BitmapDescriptor.hueGreen,
        id: 1, name: "your current location", latLng: currentLocation!));
    selectedLocation = currentLocation;
    emit(SelectedLocationState());
  }

  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoading());
    final result = await LocationService.getLocationData();
    result.fold((failure) => emit(GetCurrentLocationErrorr()), (location) {
      currentLocation = LatLng(location.latitude!, location.longitude!);
      selectedLocation = currentLocation;
      emit(GetCurrentLocationSuccess());
    });
  }

  void selectLocation(LatLng onSelectedLocation) {
    markerLocationData.clear();
    markerLocationData.add(GoogleMapModel(
      BitmapDescriptor.hueGreen,
      id: 1,
      name: "your Location",
      latLng: onSelectedLocation,
    ));

    selectedLocation = onSelectedLocation;
    //LatLng(onSelectedLocation.latitude, onSelectedLocation.longitude);
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

  void addImagetoProtofile(
    File? image,
  ) {
    //firstImage = image;
    listOfFileImagesProtofile.removeLast();
    listOfFileImagesProtofile.add(image);
    listOfFileImagesProtofile.add(File(""));
    emit(UpdateImageProtofile());
  }

  void deleteImageProtofile(File? imgae, int index) {
    listOfFileImagesProtofile.removeAt(index);
    emit(UpdateImageProtofile());
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
