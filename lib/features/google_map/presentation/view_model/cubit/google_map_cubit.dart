import 'package:app/core/di/service_locator.dart';
import 'package:app/core/utils/map_helper/location_service.dart';
import 'package:app/features/discount/presentation/view_model/cubit/discount_view_model_cubit.dart';
import 'package:app/features/drawer/presentation/cubit/drawer_cubit.dart';
import 'package:app/features/google_map/domain/entity/country_entity.dart';
import 'package:app/features/google_map/domain/usecase/get_latlng_country_use_case.dart';
import 'package:app/features/google_map/domain/usecase/google_map_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

part 'google_map_state.dart';

@injectable
class GoogleMapCubit extends Cubit<GoogleMapState> {
  GoogleMapCubit(this._googleMapUsecase, this._getLatlngCountryUseCase)
      : super(GoogleMapState());
  final GoogleMapUsecase _googleMapUsecase;
  final GetLatlngCountryUseCase _getLatlngCountryUseCase;
  Future<void> getCurrentLocation() async {
    emit(state.copyWith(
        currentLocationState: BaseLoadingState(), isSelected: false));
    final result = await LocationService.getLocationData();
    result.fold(
        (failure) =>
            emit(state.copyWith(currentLocationState: BaseErrorState(null))),
        (location) {
      currentLocation = LatLng(location.latitude!, location.longitude!);
      selectedLocation = currentLocation;
      emit(state.copyWith(currentLocationState: BaseSuccessState()));
    });
  }

  void initCurrentLocation() {
    emit(state.copyWith(isSelected: false));
    markerLocationData.clear();
    CameraPosition newLocation =
        CameraPosition(target: currentLocation!, zoom: 15);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(newLocation));

    markerLocationData.add(Marker(
      markerId: const MarkerId('1'),
      infoWindow: const InfoWindow(title: 'Your current Location'),
      position: currentLocation!,
    ));

    selectedLocation = currentLocation;
    emit(state.copyWith(isSelected: true));
  }

  void selectLocation(LatLng onSelectedLocation) {
    emit(state.copyWith(isSelected: false));
    markerLocationData.clear();
    markerLocationData.add(Marker(
      markerId: const MarkerId('1'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: onSelectedLocation,
      infoWindow: const InfoWindow(title: 'Your location'),
    ));
    selectedLocation = onSelectedLocation;
    emit(state.copyWith(isSelected: true));
  }

  void getCountryAndCityNameFromCrocd(double lat, double long) async {
    emit(state.copyWith(
        getNameOfCountry: BaseLoadingState(), isSelected: false));

    final result = await _googleMapUsecase(lat, long);

    result.fold(
        (failure) => emit(
            state.copyWith(getNameOfCountry: BaseErrorState(failure.message))),
        (response) {
      country = response;

      emit(state.copyWith(getNameOfCountry: BaseSuccessState()));
    });
  }

  void getLatLngCountry(String name) async {
    emit(state.copyWith(getLatlangcountry: BaseLoadingState()));
    final result = await _getLatlngCountryUseCase(name);
    result.fold((failure) {
      emit(state.copyWith(getLatlangcountry: BaseErrorState(failure.message)));
    }, (latlng) {
      emit(state.copyWith(
          getLatlangcountry: BaseSuccessState<LatLng>(data: latlng)));
    });
  }

  Future<void> loadMapStyle() async {
    final isDark = serviceLocator.get<DrawerCubit>();
    try {
      mapStyle = await rootBundle.loadString(
          "asset/map_styles/${isDark.themeMode == ThemeMode.dark ? "night_map_style.json" : "light_map_style.json"}");
    } catch (e) {}
  }

  CountryEntity? country;
  LatLng? currentLocation;
  LatLng? selectedLocation;
  List<Marker> markerLocationData = [];
  String? mapStyle;
  GoogleMapController? googleMapController;
}
